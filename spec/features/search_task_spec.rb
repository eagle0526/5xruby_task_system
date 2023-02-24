require 'rails_helper'
require 'capybara/rspec'


feature "Task", type: :feature do

  scenario "search title result" do

    user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
    task1 = Task.create(title: "任務一", content: "first task", state: "待處理", start_time: "2024-02-25 11:00", end_time: "2025-02-25 12:00", user_id: user.id)
    task2 = Task.create(title: "任務二", content: "second task", state: "待處理", start_time: "2024-02-26 11:00", end_time: "2025-02-26 12:00", user_id: user.id)
    task3 = Task.create(title: "任務三", content: "third task", state: "進行中", start_time: "2024-02-27 11:00", end_time: "2025-02-27 12:00", user_id: user.id)

    # 搜尋 "任務三"
    visit tasks_path
    fill_in "q_title_or_state_cont", with: task3.title
    click_on "篩選"


    expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(2)", text: task3.title)
    expect(page).not_to have_selector("tbody tr:nth-child(2) td:nth-child(2)", text: task2.title)
    expect(page).not_to have_selector("tbody tr:nth-child(3) td:nth-child(2)", text: task1.title)

  end

  scenario "search title result" do
    user = User.create(name: "user1", email: "test@gmail.com", password: "111aaa")
    task1 = Task.create(title: "任務一", content: "first task", state: "待處理", start_time: "2024-02-25 11:00", end_time: "2025-02-25 12:00", user_id: user.id)
    task2 = Task.create(title: "任務二", content: "second task", state: "進行中", start_time: "2024-02-26 11:00", end_time: "2025-02-26 12:00", user_id: user.id)
    task3 = Task.create(title: "任務三", content: "third task", state: "待處理", start_time: "2024-02-27 11:00", end_time: "2025-02-27 12:00", user_id: user.id)

    # 搜尋 "待處理"
    visit tasks_path
    fill_in "q_title_or_state_cont", with: task1.state
    click_on "篩選"

    expect(page).to have_selector("tbody tr:nth-child(1) td:nth-child(2)", text: task3.title)
    expect(page).not_to have_selector("tbody tr:nth-child(2) td:nth-child(2)", text: task2.title)
    expect(page).to have_selector("tbody tr:nth-child(2) td:nth-child(2)", text: task1.title)

  end

end