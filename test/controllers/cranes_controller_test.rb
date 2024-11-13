require "test_helper"

class CranesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cranes_new_url
    assert_response :success
  end

  test "should get create" do
    get cranes_create_url
    assert_response :success
  end

  test "should get index" do
    get cranes_index_url
    assert_response :success
  end
end
