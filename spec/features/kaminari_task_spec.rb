require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

  let!(:user) { create(:user) }  
  let!(:task) { create_list(:task, 11, user: user) }

  describe "Task kaminari task" do
    context "User logged in" do      
      
      before do        
        visit root_path
        click_on "登入"

        fill_in "email", with: "a034506618@gmail.com"
        fill_in "password", with: "111aa111"

        click_on "會員登入"

        expect(page.current_path).to eq tasks_path
        expect(page).to have_text '任務列表'
      end

      scenario "11 tasks will be divided into 3 pages, one page has 5 tasks" do  

        # page 1
        (1..5).each do |index|
          expect(page).to have_selector("tbody tr:nth-child(#{index}) td:nth-child(2)", text: "Task #{ 10 - index + 2 }")
        end

        click_on "下一頁"

        #  page 2
        (1..5).each do |index|
          expect(page).to have_selector("tbody tr:nth-child(#{index}) td:nth-child(2)", text: "Task #{ 5 - index + 2 }")
        end

        click_on "下一頁"

        # page 3
        expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(2)", text: "Task 1")

      end
    end
  end
end



