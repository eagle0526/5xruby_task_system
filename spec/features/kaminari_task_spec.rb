require 'rails_helper'
require 'capybara/rspec'


feature "Task", type: :feature do

  scenario "11 tasks will be divided into 3 pages, one page has 5 tasks" do

    user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")

    priority_arr = ["高", "中", "低"]
    state_arr = ["待處理", "進行中", "已完成"]
    
    11.times do |number|
      Task.create(title: "任務#{number}", 
                  content: "好難啊", 
                  priority: priority_arr.sample(1).first, 
                  state: state_arr.sample(1).first, 
                  classification: "程式", 
                  start_time: "2025-02-25 12:00",
                  end_time: "2025-02-26 12:00",
                  user_id: user.id
                )
                
    end

    # page 1 
    visit tasks_path    

    (1..5).each do |index|
      expect(page).to have_selector("tbody tr:nth-child(#{index}) td:nth-child(2)", text: "任務#{ 10 - index + 1 }")
    end

    # page 2
    click_on "下一頁"

    (1..5).each do |index|
      expect(page).to have_selector("tbody tr:nth-child(#{index}) td:nth-child(2)", text: "任務#{ 5 - index + 1 }")
    end
    
    # page 3 
    click_on "下一頁"

    expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(2)", text: "任務0")

  end



end