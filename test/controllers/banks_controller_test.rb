require "test_helper"

class BanksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get banks_index_url
    assert_response :success
  end

  test "should get new" do
    get banks_new_url
    assert_response :success
  end

  test "should get create" do
    get banks_create_url
    assert_response :success
  end

  test "should get edit" do
    get banks_edit_url
    assert_response :success
  end

  test "should get update" do
    get banks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get banks_destroy_url
    assert_response :success
  end
end
