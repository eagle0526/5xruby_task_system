require 'rails_helper'
require 'capybara/rspec'


feature "User", type: :feature do

  scenario "User Sign Up" do

    visit root_path
    expect(page).to have_content("首頁")

    click_on "註冊"
    fill_in "user_name", with: "yeee"
    fill_in "user_email", with: "a034506618@gmail.com"
    fill_in "user_password", with: "123aa123"
    fill_in "user_password_confirmation", with: "123aa123"
    click_on "會員註冊"

    expect(page).to have_content("yeee")

  end

  scenario "User Sign Out" do

    visit root_path
    expect(page).to have_content("首頁")

    click_on "註冊"
    fill_in "user_name", with: "yeee"
    fill_in "user_email", with: "a034506618@gmail.com"
    fill_in "user_password", with: "123aa123"
    fill_in "user_password_confirmation", with: "123aa123"
    click_on "會員註冊"

    expect(page).to have_content("yeee")
    click_on "登出"

  end

  scenario "User Login" do

    visit root_path
    expect(page).to have_content("首頁")

    click_on "註冊"
    fill_in "user_name", with: "yeee"
    fill_in "user_email", with: "a034506618@gmail.com"
    fill_in "user_password", with: "123aa123"
    fill_in "user_password_confirmation", with: "123aa123"
    click_on "會員註冊"

    expect(page).to have_content("yeee")

    # Sign Out
    click_on "登出"
    expect(page).to have_content("請先登入")

    # login
    find(:link, "登入", match: :first).click    
    fill_in "email", with: "a034506618@gmail.com"
    fill_in "password", with: "123aa123"
    click_on "會員登入"
    

    expect(page).to have_content("yeee")
    expect(page).to have_content("登入成功")

  end

end