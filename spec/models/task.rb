require 'rails_helper'



RSpec.describe Task, :type => :model do

  let!(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  it { should validate_presence_of(:title).with_message('任務標題不能為空') }
  it { should validate_presence_of(:content).with_message('任務內容不能為空') }
  it { should validate_presence_of(:start_time).with_message('任務開始時間不能為空') }
  it { should validate_presence_of(:end_time).with_message('任務結束時間不能為空') }
  
  
  describe "ransackable_attributes" do
    it "return correct attributes" do
      attributes = Task.ransackable_attributes
      expect(attributes).to eq(["classification", "content", "state_translated", "title", "priority"])      
    end
  end

  describe "aasm state transitions" do
    it 'start with the pending state' do
      expect(task.pending?).to be true
    end

    it 'state change from pending to doing' do
      task.start!
      expect(task.doing?).to be true
    end

    it 'state change from doing to finishing' do
      task.start!
      task.end!
      expect(task.finishing?).to be true
    end
  end


  describe "ransacker state translated" do
    it "maps state_translated to state column with correct values" do
      expect(Task.ransackable_attributes).to include('state_translated')

      allow(I18n).to receive(:t).with('tasks.pending').and_return('待處理')      
      allow(I18n).to receive(:t).with('tasks.doing').and_return('進行中')      
      allow(I18n).to receive(:t).with('tasks.finishing').and_return('已完成')

    end
  end

end
