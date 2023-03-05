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
    ["classification", "content", "state", "title"]         
  end


  aasm column: "state", no_direct_assignment: true do
    state :pending, initial: true
    state :doing, :ending

    # 待處理 -> 進行中
    event :start do
      transitions from: :pending, to: :doing
    end

    # 進行中 -> 已完成
    event :end do
      transitions from: :doing, to: :ending
    end
  end  


end
