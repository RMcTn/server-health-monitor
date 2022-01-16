require "application_system_test_case"

class OrganisationsUsersTest < ApplicationSystemTestCase
  setup do
    @organisations_user = organisations_users(:one)
  end

  test "visiting the index" do
    visit organisations_users_url
    assert_selector "h1", text: "Organisations users"
  end

  test "should create organisations user" do
    visit organisations_users_url
    click_on "New organisations user"

    click_on "Create Organisations user"

    assert_text "Organisations user was successfully created"
    click_on "Back"
  end

  test "should update Organisations user" do
    visit organisations_user_url(@organisations_user)
    click_on "Edit this organisations user", match: :first

    click_on "Update Organisations user"

    assert_text "Organisations user was successfully updated"
    click_on "Back"
  end

  test "should destroy Organisations user" do
    visit organisations_user_url(@organisations_user)
    click_on "Destroy this organisations user", match: :first

    assert_text "Organisations user was successfully destroyed"
  end
end
