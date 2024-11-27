require "test_helper"

class CraneFixingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get crane_fixings_index_url
    assert_response :success
  end

  test "should get new" do
    get crane_fixings_new_url
    assert_response :success
  end

  test "should get create" do
    get crane_fixings_create_url
    assert_response :success
  end

  test "should get edit" do
    get crane_fixings_edit_url
    assert_response :success
  end

  test "should get update" do
    get crane_fixings_update_url
    assert_response :success
  end

  test "should get show" do
    get crane_fixings_show_url
    assert_response :success
  end

  test "should get destroy" do
    get crane_fixings_destroy_url
    assert_response :success
  end
end
