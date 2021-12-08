require "application_system_test_case"

class TransanctionsTest < ApplicationSystemTestCase
  setup do
    @transanction = transanctions(:one)
  end

  test "visiting the index" do
    visit transanctions_url
    assert_selector "h1", text: "Transanctions"
  end

  test "creating a Transanction" do
    visit transanctions_url
    click_on "New Transanction"

    fill_in "Amount", with: @transanction.amount
    fill_in "Item", with: @transanction.item_id
    fill_in "Price", with: @transanction.price
    fill_in "User", with: @transanction.user_id
    click_on "Create Transanction"

    assert_text "Transanction was successfully created"
    click_on "Back"
  end

  test "updating a Transanction" do
    visit transanctions_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @transanction.amount
    fill_in "Item", with: @transanction.item_id
    fill_in "Price", with: @transanction.price
    fill_in "User", with: @transanction.user_id
    click_on "Update Transanction"

    assert_text "Transanction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transanction" do
    visit transanctions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transanction was successfully destroyed"
  end
end
