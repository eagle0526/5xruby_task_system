require 'rails_helper'



RSpec.describe Task, :type => :model do

  subject { described_class.new(title: "Anything",
                                content: "Anything",
                                start_time: DateTime.now, 
                                end_time: DateTime.now + 1.week,)
  } 


  it { should validate_presence_of(:title).with_message('任務標題不能為空') }
  it { should validate_presence_of(:content).with_message('任務內容不能為空') }
  # it { should validate_presence_of(:start_time).with_message('任務開始時間不能為空') }
  # it { should validate_presence_of(:end_time).with_message('任務結束時間不能為空') }
  
  
  it "is valid with valid attributes" do    

    user = User.create(name: "yee", email: "111@gmail.com", password: "111aaa")
    subject.user_id = user.id
    subject.save

    expect(subject).to be_valid
  end    

  it "is not valid without a title" do

    user = User.create(name: "yee", email: "111@gmail.com", password: "111aaa")
    subject.user_id = user.id

    subject.title = nil
    subject.save

    expect(subject).to_not be_valid
  end

  it "is not valid without a content" do
    user = User.create(name: "yee", email: "111@gmail.com", password: "111aaa")
    subject.user_id = user.id

    subject.content = nil
    subject.save

    expect(subject).to_not be_valid
  end

  it "is not valid without a start_time" do

    user = User.create(name: "yee", email: "111@gmail.com", password: "111aaa")
    subject.user_id = user.id

    subject.start_time = nil
    subject.save

    expect(subject).to_not be_valid
  end

  it "is not valid without a end_time" do

    user = User.create(name: "yee", email: "111@gmail.com", password: "111aaa")
    subject.user_id = user.id

    subject.end_time = nil
    subject.save

    expect(subject).to_not be_valid
  end

end
