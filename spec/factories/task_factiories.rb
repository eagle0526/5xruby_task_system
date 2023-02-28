FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    content { "新任務內容" }
    priority { %w[低 中 高].sample }
    state { %w[待處理 進行中 已完成].sample }
    classification "程式"
    start_time "20230228"
    end_time "20230301"    
  end
end
