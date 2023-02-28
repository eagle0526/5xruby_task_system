require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

  let!(:user) { create(:user) }  
  let!(:task) { create_list(:task, 3, user: user) }

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

      scenario "task order by create time" do                
        expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(1)", text: "3")
        expect(page).to have_selector("tbody tr:nth-child(2) td:nth-child(1)", text: "2")
        expect(page).to have_selector("tbody tr:nth-child(3) td:nth-child(1)", text: "1")
      end

    end
  end

end
