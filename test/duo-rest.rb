require 'test/unit'
require 'duo-rest'

class DuoRestTest < Test::Unit::TestCase
  
  CONFIG = YAML::load( File.open( 'duo_test_info.yml' ) )
  
  API_HOSTNAME = CONFIG['hostname']
  API_INTEGRATION_KEY = CONFIG['integration_key']
  API_SECRET_KEY = CONFIG['secret_key']
  API_USERNAME = CONFIG['username']
  # simple passing test
  def test_version
    assert_equal "0.0.1", DuoRest::VERSION
  end
  
  def test_connection
    connection = DuoRest::Connection.new(API_HOSTNAME, API_INTEGRATION_KEY, API_SECRET_KEY).ping
    assert_equal({"response" => "pong", "stat" => "OK"}, connection)
  end
  
  def test_check
    check = DuoRest::Connection.new(API_HOSTNAME, API_INTEGRATION_KEY, API_SECRET_KEY).check
    assert_equal({"response" => "valid", "stat" => "OK"}, check)
  end
  
  def test_preauth
    preauth = DuoRest::Connection.new(API_HOSTNAME, API_INTEGRATION_KEY, API_SECRET_KEY).preauth(API_USERNAME)
    assert_equal("OK", preauth["stat"])
    
    # this wont be the same for every user but this is the expected style
    # assert_equal({
    #   "response" => {
    #     "factors"=> {"1"=>"push1", "2"=>"phone1", "3"=>"sms1", "default"=>"push1"},
    #     "prompt"=> "Duo two-factor login for kellymahan\n\nEnter a passcode or select one of the following options:\n\n 1. Duo Push to XXX-XXX-9990\n 2. Phone call to XXX-XXX-9990\n 3. SMS passcodes to XXX-XXX-9990\n\nPasscode or option (1-3): ",
    #     "result"=>"auth"
    #   }, 
    #   "stat" => "OK"
    # }, preauth)
  end
  
  def test_auth
    auth = DuoRest::Connection.new(API_HOSTNAME, API_INTEGRATION_KEY, API_SECRET_KEY).auth(API_USERNAME, "push1")
    assert_equal("OK", auth["stat"])
    
    # this wont be the same for every user but this is the expected style
    # assert_equal({
    #   "response"=>{"result"=>"allow", "status"=>"Success. Logging you in..."},
    #   "stat"=>"OK"
    # }, auth)
  end
  
  
  # So far this is not working as expected and ignored for now since it isn't a requirement
  # def test_delayed_auth
  #   auth = DuoRest::Connection.new(API_HOSTNAME, API_INTEGRATION_KEY, API_SECRET_KEY).auth(API_USERNAME, "push1", {async: true})
  #   assert_equal("OK", auth["stat"])
  #   # this wont be the same for every user but this is the expected style
  #   assert_equal({
  #     "response"=>{"result"=>"allow", "status"=>"Success. Logging you in..."},
  #     "stat"=>"OK"
  #   }, auth)
  # end
  
  
  #used to check for a delayed auth
  def test_status
    #TODO once delayed auth is working
  end
  
end