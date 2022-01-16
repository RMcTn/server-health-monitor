require "test_helper"

class OrganisationsUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organisations_user = organisations_users(:one)
  end

  test "should get index" do
    get organisations_users_url
    assert_response :success
  end

  test "should get new" do
    get new_organisations_user_url
    assert_response :success
  end

  test "should create organisations_user" do
    assert_difference("OrganisationsUser.count") do
      post organisations_users_url, params: { organisations_user: {  } }
    end

    assert_redirected_to organisations_user_url(OrganisationsUser.last)
  end

  test "should show organisations_user" do
    get organisations_user_url(@organisations_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_organisations_user_url(@organisations_user)
    assert_response :success
  end

  test "should update organisations_user" do
    patch organisations_user_url(@organisations_user), params: { organisations_user: {  } }
    assert_redirected_to organisations_user_url(@organisations_user)
  end

  test "should destroy organisations_user" do
    assert_difference("OrganisationsUser.count", -1) do
      delete organisations_user_url(@organisations_user)
    end

    assert_redirected_to organisations_users_url
  end
end
