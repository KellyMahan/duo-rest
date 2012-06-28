require 'open-uri'
require 'net/http'
require 'net/https'
require "uri"
require 'json'
require 'base64'
require 'openssl'
require "cgi"

module DuoRest
  
  class Connection
    
    REST_VERSION = 'rest/v1'
    
    attr_accessor :api_hostname, :response, :http, :user, :key
    
    def initialize(api_hostname, user, key)
      @key = key
      @user = user
      @api_hostname = api_hostname
      @http = Net::HTTP.new("#{@api_hostname}", 443)
      @http.use_ssl = true
    end
    
    def ping
      url = "#{REST_VERSION}/ping"
      get(url)
    end
    
    def check
      url = "#{REST_VERSION}/check"
      get(url)
    end
    
    def preauth(user)
      url = "#{REST_VERSION}/preauth"
      data = {user: user}
      post(url, data)
    end
    
    def auth(user, factor_method, options = {})
      ipaddress = options[:ipaddress] || ''
      async = options[:async]
      url = "#{REST_VERSION}/auth"
      data = {auto: factor_method, factor: 'auto', ipaddr: ipaddress, user: user}
      data.merge({async: "1"}) if async
      post(url, data)
    end
    
    private
    
    def get(url)
      uri = URI("https://#{@api_hostname}/#{url}")
      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth @user, sign_hmac(url, '', "GET")
      
      @response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http| http.request(req) }
      JSON.parse(@response.body).to_hash
    end
    
    def post(url, data)
      uri = URI("https://#{@api_hostname}/#{url}")
      req = Net::HTTP::Post.new(uri.request_uri)
      pass = sign_hmac(url, to_query(data), "POST")
      puts pass
      req.basic_auth @user, pass
      req.set_form_data(data)
      @response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http| http.request(req) }
      JSON.parse(@response.body).to_hash
    end
    
    def sign_hmac(url, data, method)
      request = "#{method}\n"
      request << "#{@api_hostname}\n"
      request << "/#{url}\n"
      request << "#{data}"
      # puts "\n"
      # puts request
      sig = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), @key, request)
      return sig
    end
    
    def to_query(hash)
      #puts hash
      hash.map{|k,v| "#{k}=#{CGI.escape(v)}"}.join("&")
    end
    
  end
  
end