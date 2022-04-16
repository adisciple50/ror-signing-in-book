require "application_system_test_case"

class EntriesTest < ApplicationSystemTestCase
  setup do
    @entry = entries(:one)
    @admin = admins(:one)
  end

  def login!
    visit root_url
    click_on "Admins"
    fill_in "Username",with:@admin.username
    fill_in "Password",with:"test1"
    click_on "login"
  end

  test "visiting the index" do
    login!

    click_on "View All Entries"
    assert_selector "h1", text: "Entries"
  end

  test "should create entry" do
    login!

    visit entries_url
    click_on "New entry"

    fill_in "Username", with: @entry.username
    fill_in "Mobile phone", with: @entry.mobile_phone
    fill_in "Name", with: @entry.name
    fill_in "Time in", with: @entry.time_in
    fill_in "Time out", with: @entry.time_out
    click_on "Create Entry"

    assert_text "Entry was successfully created"
    click_on "Back"
  end

  test "should update Entry" do
    login!

    visit entry_url(@entry)
    click_on "Edit this entry", match: :first

    fill_in "Mobile phone", with: @entry.mobile_phone
    fill_in "Name", with: @entry.name
    fill_in "Time in", with: @entry.time_in
    fill_in "Time out", with: @entry.time_out
    click_on "Update Entry"

    assert_text "Entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Entry" do
    login!
    visit entry_url(@entry)
    click_on "Destroy this entry", match: :first

    assert_text "Entry was successfully destroyed"
  end
end
