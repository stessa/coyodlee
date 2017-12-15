require 'test_helper'
require 'envestnet/yodlee/utils'

class Envestnet::Yodlee::UtilsTest < Minitest::Test
  include ::Envestnet::Yodlee::Utils

  def test_uncapitalized_camelize
    assert_equal uncapitalized_camelize('hello_world'), 'helloWorld'
    assert_equal uncapitalized_camelize('hello'), 'hello'
    assert_equal uncapitalized_camelize('one_two_three'), 'oneTwoThree'
  end
end
