require 'test/unit'
require 'duo-rest'

class DuoRestTest < Test::Unit::TestCase
  
  def test_version
    assert_equal "0.0.1", DuoRest::VERSION
  end
  
end