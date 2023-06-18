require "application_system_test_case"

class ControllerCommentsTest < ApplicationSystemTestCase
  setup do
    @controller_comment = controller_comments(:one)
  end

  test "visiting the index" do
    visit controller_comments_url
    assert_selector "h1", text: "Controller comments"
  end

  test "should create controller comment" do
    visit controller_comments_url
    click_on "New controller comment"

    click_on "Create Controller comment"

    assert_text "Controller comment was successfully created"
    click_on "Back"
  end

  test "should update Controller comment" do
    visit controller_comment_url(@controller_comment)
    click_on "Edit this controller comment", match: :first

    click_on "Update Controller comment"

    assert_text "Controller comment was successfully updated"
    click_on "Back"
  end

  test "should destroy Controller comment" do
    visit controller_comment_url(@controller_comment)
    click_on "Destroy this controller comment", match: :first

    assert_text "Controller comment was successfully destroyed"
  end
end
