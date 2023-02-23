class Task < ApplicationRecord
  acts_as_paranoid
  
  validates :title, presence: true
  validates :content, presence: true
  # validates :start_time, presence: true
  # validates :end_time, presence: true
  
  belongs_to :user


  def self.ransackable_attributes(auth_object = nil)
    ["classification", "content", "state", "title"]         
  end
end
