class Task < ApplicationRecord
  include AASM
  acts_as_paranoid
  paginates_per 5
  
  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  belongs_to :user



  def self.ransackable_attributes(auth_object = nil)
    ["classification", "content", "state_translated", "title"]         
  end


  ransacker :state_translated, formatter: proc { |v|
    case v
    when I18n.t('tasks.pending') then 'pending'
    when I18n.t('tasks.doing') then 'doing'
    when I18n.t('tasks.finishing') then 'finishing'
    else nil
    end
  } do |parent|
    parent.table[:state]    
  end


  aasm column: "state", no_direct_assignment: true do
    state :pending, initial: true
    state :doing, :finishing

    # 待處理 -> 進行中
    event :start do
      transitions from: :pending, to: :doing
    end

    # 進行中 -> 已完成
    event :end do
      transitions from: :doing, to: :finishing
    end
  end  


end
