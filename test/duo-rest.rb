require 'test/unit'
require 'duo-rest'

class DuoRestTest < Test::Unit::TestCase
  
  # simple passing test
  def test_version
    assert_equal "0.0.1", DuoRest::VERSION
  end
  
  
  
end