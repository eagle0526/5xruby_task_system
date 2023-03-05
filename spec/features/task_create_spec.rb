require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

  let!(:user) { create(:user) }

  describe "create a new task" do
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

      scenario "successed" do

        click_on "新增任務"
        fill_in "task_title", with: "新任務"
        fill_in "task_content", with: "我是新任務我是新任務我是新任務我是新任務我是新任務"
        select "高", from: "task_priority"        
        fill_in "task_classification", with: "後端工程師"
  
        fill_in "task_start_time", with: "2023-02-24 11:55"
        find("#task_start_time").click
        find(".flatpickr-day.today").click
        find(".flatpickr-time").click
        find(".arrowDown").click

        fill_in "task_end_time", with: "2023-02-17 12:05"
        find("#task_end_time").click
        find(".flatpickr-day.today").click
        find(".flatpickr-time").click      
        find(".arrowUp").click

        click_on "新增任務"

        expect(page).to have_content("成功新增任務")          
      end


      scenario "Failed" do
        click_on "新增任務"
        page.fill_in 'task_title', with: '123'
    
        click_on '新增任務'
        expect(page).to have_text '任務內容不能為空'
        expect(page).to have_text '任務開始時間不能為空'
        expect(page).to have_text '任務結束時間不能為空'
      end

    end
  end
end
