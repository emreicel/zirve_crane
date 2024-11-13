require "application_system_test_case"

class CraneOwnersTest < ApplicationSystemTestCase
  setup do
    @crane_owner = crane_owners(:one)
  end

  test "visiting the index" do
    visit crane_owners_url
    assert_selector "h1", text: "Crane owners"
  end

  test "should create crane owner" do
    visit crane_owners_url
    click_on "New crane owner"

    fill_in "Crane owner address", with: @crane_owner.crane_owner_address
    fill_in "Crane owner contact", with: @crane_owner.crane_owner_contact
    fill_in "Crane owner contact email", with: @crane_owner.crane_owner_contact_email
    fill_in "Crane owner contact phone", with: @crane_owner.crane_owner_contact_phone
    fill_in "Crane owner name", with: @crane_owner.crane_owner_name
    fill_in "Crane owner phone", with: @crane_owner.crane_owner_phone
    fill_in "Crane owner vat office", with: @crane_owner.crane_owner_vat_office
    click_on "Create Crane owner"

    assert_text "Crane owner was successfully created"
    click_on "Back"
  end

  test "should update Crane owner" do
    visit crane_owner_url(@crane_owner)
    click_on "Edit this crane owner", match: :first

    fill_in "Crane owner address", with: @crane_owner.crane_owner_address
    fill_in "Crane owner contact", with: @crane_owner.crane_owner_contact
    fill_in "Crane owner contact email", with: @crane_owner.crane_owner_contact_email
    fill_in "Crane owner contact phone", with: @crane_owner.crane_owner_contact_phone
    fill_in "Crane owner name", with: @crane_owner.crane_owner_name
    fill_in "Crane owner phone", with: @crane_owner.crane_owner_phone
    fill_in "Crane owner vat office", with: @crane_owner.crane_owner_vat_office
    click_on "Update Crane owner"

    assert_text "Crane owner was successfully updated"
    click_on "Back"
  end

  test "should destroy Crane owner" do
    visit crane_owner_url(@crane_owner)
    click_on "Destroy this crane owner", match: :first

    assert_text "Crane owner was successfully destroyed"
  end
end
