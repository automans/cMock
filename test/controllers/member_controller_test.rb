require 'test_helper'

class MemberControllerTest < ActionDispatch::IntegrationTest
  test "should get user" do
    get member_user_url
    assert_response :success
  end

end
