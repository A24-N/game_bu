require "test_helper"

class IntroducesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get introduces_index_url
    assert_response :success
  end

  test "should get new" do
    get introduces_new_url
    assert_response :success
  end

  test "should get edit" do
    get introduces_edit_url
    assert_response :success
  end
end
