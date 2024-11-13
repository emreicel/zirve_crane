require "test_helper"

class CraneOwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crane_owner = crane_owners(:one)
  end

  test "should get index" do
    get crane_owners_url
    assert_response :success
  end

  test "should get new" do
    get new_crane_owner_url
    assert_response :success
  end

  test "should create crane_owner" do
    assert_difference("CraneOwner.count") do
      post crane_owners_url, params: { crane_owner: { crane_owner_address: @crane_owner.crane_owner_address, crane_owner_contact: @crane_owner.crane_owner_contact, crane_owner_contact_email: @crane_owner.crane_owner_contact_email, crane_owner_contact_phone: @crane_owner.crane_owner_contact_phone, crane_owner_name: @crane_owner.crane_owner_name, crane_owner_phone: @crane_owner.crane_owner_phone, crane_owner_vat_office: @crane_owner.crane_owner_vat_office } }
    end

    assert_redirected_to crane_owner_url(CraneOwner.last)
  end

  test "should show crane_owner" do
    get crane_owner_url(@crane_owner)
    assert_response :success
  end

  test "should get edit" do
    get edit_crane_owner_url(@crane_owner)
    assert_response :success
  end

  test "should update crane_owner" do
    patch crane_owner_url(@crane_owner), params: { crane_owner: { crane_owner_address: @crane_owner.crane_owner_address, crane_owner_contact: @crane_owner.crane_owner_contact, crane_owner_contact_email: @crane_owner.crane_owner_contact_email, crane_owner_contact_phone: @crane_owner.crane_owner_contact_phone, crane_owner_name: @crane_owner.crane_owner_name, crane_owner_phone: @crane_owner.crane_owner_phone, crane_owner_vat_office: @crane_owner.crane_owner_vat_office } }
    assert_redirected_to crane_owner_url(@crane_owner)
  end

  test "should destroy crane_owner" do
    assert_difference("CraneOwner.count", -1) do
      delete crane_owner_url(@crane_owner)
    end

    assert_redirected_to crane_owners_url
  end
end
