require "application_system_test_case"

class CodesTest < ApplicationSystemTestCase
  setup do
    @code = codes(:one)
    @user = users(:one)
    @banner = banners(:one)
    @banner4 = banners(:four)
    @item = items(:one)
    @inventory = inventories(:one)
    @code = codes(:one)
  end
  
  test "login success" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    assert_text "No1"
    assert_text "Banners"
  end
  
  test "login failed" do
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "555"
    click_on "login"
    assert_text "Wrong Email or Password"
  end
  
  test "like banner" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/gacha"
    assert_difference("@banner4.likes.count", 1) do
      click_on "like", match: :first
    end
    click_on "Show Like People", match: :first
    assert_text "#{@user.name}"
  end
  
  
  test "roll gacha success" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/gacha"
    click_on "No1", match: :first
    click_on "pull 1", match: :first
    assert_text "9950"
    visit "/gacha"
    click_on "No1", match: :first
    click_on "pull 10", match: :first
    assert_text "9450"
  end
  
  
  test "roll gacha fail" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/gacha"
    click_on "No4", match: :first
    click_on "pull 1", match: :first
    assert_text "You don't have enough credit"
    visit "/gacha"
    click_on "No4", match: :first
    click_on "pull 10", match: :first
    assert_text "You don't have enough credit"
  end
  
  test "sell item success" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/inventory"
    fill_in "Price", with: "100"
    fill_in "Amount", with: "1"
    click_on "Sell", match: :first    
    assert_text "9"
    assert_text "100"
  end
  
  test "sell item fail" do
  visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/inventory"
    
    fill_in "Price", with: "100"
    fill_in "Amount", with: "100"
    click_on "Sell", match: :first
    assert_text "reasonable amount"
  end
  
  test "buy item success" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/market"
    
    fill_in "Amount", with: "1"
    click_on "Buy", match: :first    
    assert_text "9880"
  end
  
  test "buy item fail" do
  visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/market"
    
    fill_in "Amount", with: "100"
    click_on "Buy", match: :first
    assert_text "reasonable amount"
  end
  
  
  test "redeem code success" do
  
    visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/redeem"
    
    fill_in "Code", with: @code.code
    click_on "redeem", match: :first    
    assert_text "22000"
  end
  
  test "redeem code fail" do
  visit "/main"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "one"
    click_on "login"
    visit "/redeem"
    
    fill_in "Code", with: "10011"
    click_on "redeem", match: :first
    assert_text "Code with Wrong Code or Expired or Already Redeemed"
  end
  
end
