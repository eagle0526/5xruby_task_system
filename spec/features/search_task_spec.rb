require 'rails_helper'
require 'capybara/rspec'


feature "Task", type: :feature do

  let!(:user) { create(:user) }  
  let!(:task) { create_list(:task, 5, user: user) }

  describe "Task list" do
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

      scenario "search state result" do  

        # 搜尋 "進行中"        
        fill_in "q_title_or_state_cont", with: "待處理"
        click_on "篩選"

        expect(page).to have_text '待處理'
        expect(page).not_to have_text '進行中'
        expect(page).not_to have_text '已完成'
      end

      scenario "search title result" do  

        # 搜尋 "Task 1"        
        fill_in "q_title_or_state_cont", with: "Task 1"
        click_on "篩選"

        expect(page).to have_text 'Task 1'
        expect(page).not_to have_text 'Task 2'
        expect(page).not_to have_text 'Task 3'
      end

    end
  end
end

