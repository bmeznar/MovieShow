require "test_helper"

class CreateTrailersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @create_trailer = create_trailers(:one)
  end

  test "should get index" do
    get create_trailers_url
    assert_response :success
  end

  test "should get new" do
    get new_create_trailer_url
    assert_response :success
  end

  test "should create create_trailer" do
    assert_difference('CreateTrailer.count') do
      post create_trailers_url, params: { create_trailer: { videoID: @create_trailer.videoID } }
    end

    assert_redirected_to create_trailer_url(CreateTrailer.last)
  end

  test "should show create_trailer" do
    get create_trailer_url(@create_trailer)
    assert_response :success
  end

  test "should get edit" do
    get edit_create_trailer_url(@create_trailer)
    assert_response :success
  end

  test "should update create_trailer" do
    patch create_trailer_url(@create_trailer), params: { create_trailer: { videoID: @create_trailer.videoID } }
    assert_redirected_to create_trailer_url(@create_trailer)
  end

  test "should destroy create_trailer" do
    assert_difference('CreateTrailer.count', -1) do
      delete create_trailer_url(@create_trailer)
    end

    assert_redirected_to create_trailers_url
  end
end
