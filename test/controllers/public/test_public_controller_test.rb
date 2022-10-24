require "test_helper"

class Public::TestPublicControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_test_public_new_url
    assert_response :success
  end
end
