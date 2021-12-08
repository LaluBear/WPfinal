require "application_system_test_case"

class BannerItemsTest < ApplicationSystemTestCase
  setup do
    @banner_item = banner_items(:one)
  end

  test "visiting the index" do
    visit banner_items_url
    assert_selector "h1", text: "Banner Items"
  end

  test "creating a Banner item" do
    visit banner_items_url
    click_on "New Banner Item"

    fill_in "Amount", with: @banner_item.amount
    fill_in "Banner", with: @banner_item.banner_id
    fill_in "Item", with: @banner_item.item_id
    fill_in "Rate", with: @banner_item.rate
    click_on "Create Banner item"

    assert_text "Banner item was successfully created"
    click_on "Back"
  end

  test "updating a Banner item" do
    visit banner_items_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @banner_item.amount
    fill_in "Banner", with: @banner_item.banner_id
    fill_in "Item", with: @banner_item.item_id
    fill_in "Rate", with: @banner_item.rate
    click_on "Update Banner item"

    assert_text "Banner item was successfully updated"
    click_on "Back"
  end

  test "destroying a Banner item" do
    visit banner_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Banner item was successfully destroyed"
  end
end
