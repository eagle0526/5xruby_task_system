require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  describe "delete task" do
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

      scenario "Successed delete" do
        click_on "刪除"
        expect(page).to have_content("刪掉任務")  
      end

    end
  end
end
