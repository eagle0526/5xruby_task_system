require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  describe "edit task" do
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

      scenario "Successed edit" do

        click_on "編輯"
        fill_in "task_title", with: "新任務 - 改"
        fill_in "task_content", with: "改任務的內容"

        click_on "更新任務"

        expect(page).to have_content("成功更新任務")
        expect(page).to have_content("新任務 - 改")
        expect(page).to have_content("改任務的內容")     
      end


      scenario "Failed edit" do
        click_on "新增任務"
        page.fill_in 'task_title', with: ''
    
        click_on '新增任務'
        expect(page).to have_text '任務內容不能為空'

      end

    end
  end
end
