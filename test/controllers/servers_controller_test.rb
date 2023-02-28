require "test_helper"

class ServersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @server = servers(:one)
    @organisation = @server.organisation
    @user = users(:one)
  end

  test "should get index when signed in" do
    sign_in @user
    get organisation_servers_url(@organisation)
    assert_response :success
  end

  test "should get index when not signed in" do
    get organisation_server_url(@organisation, @server)
    assert_response :redirect
  end

  test "should get new when signed in" do
    sign_in @user
    get new_organisation_server_url(@organisation)
    assert_response :success
  end

  test "should create server" do
    hostname = "HOSTNAME"
    sign_in @user
    assert_difference("Server.count") do
      post organisation_servers_url(@organisation), params: { server: { hostname: hostname, protocol: Server::PROTOCOLS.first, name: "Server" } }
    end

    assert_redirected_to organisation_server_url(@organisation, Server.last)
    assert_equal Server.last.hostname, hostname
  end

  test "should show server" do
    sign_in @user
    get organisation_server_url(@organisation, @server)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_organisation_server_url(@organisation, @server)
    assert_response :success
  end

  test "should update server" do
    sign_in @user
    new_hostname = "NewHostname"
    patch organisation_server_url(@organisation, @server), params: { server: { hostname: new_hostname } }
    assert_redirected_to organisation_server_url(@organisation, @server)
    assert_equal new_hostname, @server.reload.hostname
  end

  test "should destroy server" do
    sign_in @user
    assert_difference("Server.count", -1) do
      delete organisation_server_url(@organisation, @server)
    end

    assert_redirected_to organisation_url(@organisation)
  end
end
