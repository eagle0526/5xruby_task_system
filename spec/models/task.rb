require 'rails_helper'



RSpec.describe Task, :type => :model do

  it { should validate_presence_of(:title).with_message('任務標題不能為空') }
  it { should validate_presence_of(:content).with_message('任務內容不能為空') }
  it { should validate_presence_of(:start_time).with_message('任務開始時間不能為空') }
  it { should validate_presence_of(:end_time).with_message('任務結束時間不能為空') }
  
  
  describe "ransackable_attributes" do
    it "return correct attributes" do

      attributes = Task.ransackable_attributes
      expect(attributes).to eq(["classification", "content", "state", "title"])
      
    end
  end

end
