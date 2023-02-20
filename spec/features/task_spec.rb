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
      select "High", from: "task_priority"
      select "Pending", from: "task_state"
      fill_in "task_classification", with: "後端工程師"
      fill_in "task_start_time", with: "2023-02-23 11:00"
      fill_in "task_end_time", with: "2023-02-24 15:00"
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

      task = Task.create(title: "舊任務", content: "舊任務內容", user_id: user.id)
      
      visit edit_task_path(task)
      fill_in "task_title", with: "新任務 - 改"
      fill_in "task_content", with: "改任務的內容"
      click_button "新增任務"
      
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



#   scenario "Task CURD" do    
#     # step 1 - index
#     visit tasks_path    
#     expect(page).to have_content("任務列表")

#     # step 2 - new & create
#     click_link "新增任務" 
#     fill_in "task_title", with: "新任務"
#     fill_in "task_content", with: "我是新任務我是新任務我是新任務我是新任務我是新任務"
#     select "High", from: "task_priority"
#     select "Pending", from: "task_state"
#     fill_in "task_classification", with: "後端工程師"
#     fill_in "task_start_time", with: "2023-02-23 11:00"
#     fill_in "task_end_time", with: "2023-02-24 15:00"
#     # select "yeee", from: "task_user_id"    
    

#     user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
#     fill_in "task_user_id", with: "#{user.id}"
    
    
#     click_on "新增任務"     
#     # 確認是否有存進去
#     task = Task.last
#     expect(task.title).to eq("新任務")
        
#     # 並確認是否有新增任務成功
#     expect(page).to have_content("新任務")
    

#     # step 3 - read
#     click_on "#{task.id}"
#     expect(page).to have_content("任務詳細資料")
#     click_on "回上一頁"
#     expect(page).to have_content("任務列表")

#     #step 4 - edit & update
#     click_on "編輯"
#     fill_in "task_title", with: "新任務 - 改"
#     fill_in "task_content", with: "1231232"
#     click_on "新增任務" 

    # p "-" * 50
    # p task
    # p "-" * 50
          
    # expect(task.title).to eq("新任務 - 改")
        
    # # 並確認是否有新增任務成功
    # expect(page).to have_content("新任務 - 改")

    # save_and_open_page
#   end
end

    # p "-" * 50
    # p task
    # p "-" * 50