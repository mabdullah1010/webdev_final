require "test_helper"

class SessionControllersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @session_controller = session_controllers(:one)
  end

  test "should get index" do
    get session_controllers_url
    assert_response :success
  end

  test "should get new" do
    get new_session_controller_url
    assert_response :success
  end

  test "should create session_controller" do
    assert_difference("SessionController.count") do
      post session_controllers_url, params: { session_controller: { Session: @session_controller.Session } }
    end

    assert_redirected_to session_controller_url(SessionController.last)
  end

  test "should show session_controller" do
    get session_controller_url(@session_controller)
    assert_response :success
  end

  test "should get edit" do
    get edit_session_controller_url(@session_controller)
    assert_response :success
  end

  test "should update session_controller" do
    patch session_controller_url(@session_controller), params: { session_controller: { Session: @session_controller.Session } }
    assert_redirected_to session_controller_url(@session_controller)
  end

  test "should destroy session_controller" do
    assert_difference("SessionController.count", -1) do
      delete session_controller_url(@session_controller)
    end

    assert_redirected_to session_controllers_url
  end
end
