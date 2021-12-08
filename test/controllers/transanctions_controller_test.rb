require "test_helper"

class TransanctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transanction = transanctions(:one)
  end

  test "should get index" do
    get transanctions_url
    assert_response :success
  end

  test "should get new" do
    get new_transanction_url
    assert_response :success
  end

  test "should create transanction" do
    assert_difference('Transanction.count') do
      post transanctions_url, params: { transanction: { amount: @transanction.amount, item_id: @transanction.item_id, price: @transanction.price, user_id: @transanction.user_id } }
    end

    assert_redirected_to transanction_url(Transanction.last)
  end

  test "should show transanction" do
    get transanction_url(@transanction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transanction_url(@transanction)
    assert_response :success
  end

  test "should update transanction" do
    patch transanction_url(@transanction), params: { transanction: { amount: @transanction.amount, item_id: @transanction.item_id, price: @transanction.price, user_id: @transanction.user_id } }
    assert_redirected_to transanction_url(@transanction)
  end

  test "should destroy transanction" do
    assert_difference('Transanction.count', -1) do
      delete transanction_url(@transanction)
    end

    assert_redirected_to transanctions_url
  end
end
