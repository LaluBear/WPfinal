require "test_helper"

class BannerItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @banner_item = banner_items(:one)
  end

  test "should get index" do
    get banner_items_url
    assert_response :success
  end

  test "should get new" do
    get new_banner_item_url
    assert_response :success
  end

  test "should create banner_item" do
    assert_difference('BannerItem.count') do
      post banner_items_url, params: { banner_item: { amount: @banner_item.amount, banner_id: @banner_item.banner_id, item_id: @banner_item.item_id, rate: @banner_item.rate } }
    end

    assert_redirected_to banner_item_url(BannerItem.last)
  end

  test "should show banner_item" do
    get banner_item_url(@banner_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_banner_item_url(@banner_item)
    assert_response :success
  end

  test "should update banner_item" do
    patch banner_item_url(@banner_item), params: { banner_item: { amount: @banner_item.amount, banner_id: @banner_item.banner_id, item_id: @banner_item.item_id, rate: @banner_item.rate } }
    assert_redirected_to banner_item_url(@banner_item)
  end

  test "should destroy banner_item" do
    assert_difference('BannerItem.count', -1) do
      delete banner_item_url(@banner_item)
    end

    assert_redirected_to banner_items_url
  end
end
