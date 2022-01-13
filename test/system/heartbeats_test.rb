require "application_system_test_case"

class HeartbeatsTest < ApplicationSystemTestCase
  setup do
    @heartbeat = heartbeats(:one)
  end

  test "visiting the index" do
    visit heartbeats_url
    assert_selector "h1", text: "Heartbeats"
  end

  test "should create heartbeat" do
    visit heartbeats_url
    click_on "New heartbeat"

    click_on "Create Heartbeat"

    assert_text "Heartbeat was successfully created"
    click_on "Back"
  end

  test "should update Heartbeat" do
    visit heartbeat_url(@heartbeat)
    click_on "Edit this heartbeat", match: :first

    click_on "Update Heartbeat"

    assert_text "Heartbeat was successfully updated"
    click_on "Back"
  end

  test "should destroy Heartbeat" do
    visit heartbeat_url(@heartbeat)
    click_on "Destroy this heartbeat", match: :first

    assert_text "Heartbeat was successfully destroyed"
  end
end
