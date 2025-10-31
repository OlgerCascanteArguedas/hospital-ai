require "test_helper"

class PatientsProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get patients_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get patients_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get patients_profiles_update_url
    assert_response :success
  end
end
