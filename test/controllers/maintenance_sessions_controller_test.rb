require 'test_helper'

class MaintenanceSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get maintenance_sessions_new_url
    assert_response :success
  end

end
