require 'rails_helper'
require 'capybara/rspec'

feature "Task", type: :feature do

    scenario "visit index" do
      visit tasks_path
      expect(page).to have_content("任務列表")
    end

    scenario "create a new task" do
      visit new_task_path
      fill_in "task_title", with: "新任務"
      fill_in "task_content", with: "我是新任務我是新任務我是新任務我是新任務我是新任務"
      select "高", from: "task_priority"
      select "待處理", from: "task_state"
      fill_in "task_classification", with: "後端工程師"

      

      # select "yeee", from: "task_user_id"    
      
      # 先固定寫一過 user 進去   
      user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
      fill_in "task_user_id", with: "#{user.id}"            
      click_on "新增任務"    
          
      expect(page).to have_content("成功新增任務")
      expect(page).to have_content("新任務")
      expect(page).to have_content("我是新任務我是新任務我是新任務我是新任務我是新任務")
    end

    scenario "update an existing task" do
      user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")

      task = Task.create(title: "舊任務", content: "舊任務內容", start_time: "2024-02-25 11:00", end_time: "2025-02-25 12:00", user_id: user.id)
      
      visit edit_task_path(task)
      fill_in "task_title", with: "新任務 - 改"
      fill_in "task_content", with: "改任務的內容"
      click_button "更新任務"
      
      expect(page).to have_content("成功更新任務")
      expect(page).to have_content("新任務 - 改")
      expect(page).to have_content("改任務的內容")

    end
    

    scenario "view a list of task" do

      user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")

      task1 = Task.create(title: "task1", content: "first task", user_id: user.id)
      task2 = Task.create(title: "task2", content: "second task", user_id: user.id)
      visit tasks_path

      expect(page).to have_content(task1.title)
      expect(page).to have_content(task1.content)
      expect(page).to have_content(task2.title)
      expect(page).to have_content(task2.content)
    end

    scenario "delete an existing task" do

      user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
      task1 = Task.create(title: "task1", content: "first task", user_id: user.id)

      visit tasks_path
      click_link "delete"
      expect(page).to_not have_content(task1.title)
      expect(page).to_not have_content(task1.content)
    end


    # scenario "task order by create time" do
    #   user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
    #   task1 = Task.create(title: "task1", content: "first task", user_id: user.id)
    #   task2 = Task.create(title: "task2", content: "second task", user_id: user.id)
    #   task3 = Task.create(title: "task3", content: "third task", user_id: user.id)

    #   visit tasks_path
      
    #   expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(2)", text: task3.title)
    #   expect(page).to have_selector("tbody tr:nth-child(2) td:nth-child(2)", text: task2.title)
    #   expect(page).to have_selector("tbody tr:nth-child(3) td:nth-child(2)", text: task1.title)      
    # end


end

    # p "-" * 50
    # p task
    # p "-" * 50