require "test_helper"

class WatchlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get watchlists_update_url
    assert_response :success
  end
end
