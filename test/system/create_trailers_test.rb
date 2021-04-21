require "application_system_test_case"

class CreateTrailersTest < ApplicationSystemTestCase
  setup do
    @create_trailer = create_trailers(:one)
  end

  test "visiting the index" do
    visit create_trailers_url
    assert_selector "h1", text: "Create Trailers"
  end

  test "creating a Create trailer" do
    visit create_trailers_url
    click_on "New Create Trailer"

    fill_in "Videoid", with: @create_trailer.videoID
    click_on "Create Create trailer"

    assert_text "Create trailer was successfully created"
    click_on "Back"
  end

  test "updating a Create trailer" do
    visit create_trailers_url
    click_on "Edit", match: :first

    fill_in "Videoid", with: @create_trailer.videoID
    click_on "Update Create trailer"

    assert_text "Create trailer was successfully updated"
    click_on "Back"
  end

  test "destroying a Create trailer" do
    visit create_trailers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Create trailer was successfully destroyed"
  end
end
