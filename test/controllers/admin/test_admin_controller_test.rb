require "test_helper"

class Admin::TestAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_test_admin_new_url
    assert_response :success
  end
end
