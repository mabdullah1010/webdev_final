require "application_system_test_case"

class SessionControllersTest < ApplicationSystemTestCase
  setup do
    @session_controller = session_controllers(:one)
  end

  test "visiting the index" do
    visit session_controllers_url
    assert_selector "h1", text: "Session controllers"
  end

  test "should create session controller" do
    visit session_controllers_url
    click_on "New session controller"

    fill_in "Session", with: @session_controller.Session
    click_on "Create Session controller"

    assert_text "Session controller was successfully created"
    click_on "Back"
  end

  test "should update Session controller" do
    visit session_controller_url(@session_controller)
    click_on "Edit this session controller", match: :first

    fill_in "Session", with: @session_controller.Session
    click_on "Update Session controller"

    assert_text "Session controller was successfully updated"
    click_on "Back"
  end

  test "should destroy Session controller" do
    visit session_controller_url(@session_controller)
    click_on "Destroy this session controller", match: :first

    assert_text "Session controller was successfully destroyed"
  end
end
