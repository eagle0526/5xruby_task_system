require 'rails_helper'
require 'capybara/rspec'


feature "Task", type: :feature do

  let!(:user) { create(:user) }  
  let!(:task) { create_list(:task, 10, user: user) }

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

        # 搜尋 "已完成"        
        fill_in "q_state_translated_cont", with: "已完成"
        click_on "篩選"

        expect(page).to have_text '已完成'
        expect(page).not_to have_text '進行中'
        expect(page).not_to have_text '待處理'
      end

      scenario "search title result" do  

        # 搜尋 "task.last.title"                
        fill_in "q_title_cont", with: task.last.title        
        click_on "篩選"

        expect(page).to have_text task.last.title
        expect(page).not_to have_text task.first.title        
      end

      scenario "search priority result" do  

        # 搜尋 "高"                
        select "高", from: "q_priority_eq"        
        click_on "篩選"

        expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(4)", text: "高")

        # 搜尋 "中"
        click_on "清空搜尋"
        select "中", from: "q_priority_eq"        
        click_on "篩選"

        expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(4)", text: "中")

        # 搜尋 "低"
        click_on "清空搜尋"
        select "低", from: "q_priority_eq"        
        click_on "篩選"

        expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(4)", text: "低")
      end

    end
  end
end

