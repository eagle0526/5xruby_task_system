require 'rails_helper'



RSpec.describe User, :type => :model do

  it { should validate_presence_of(:email).with_message('信箱不能為空') }
  it { should validate_presence_of(:password).with_message('密碼至少要8個字') }

  describe "encrypts password" do
    it "before create" do
      user = FactoryBot.create(:user, password: "password123")
      expected_password = Digest::SHA1.hexdigest("addpassword123salt")
      expect(user.password).to eq(expected_password)
    end
  end

  describe "login method" do
    let!(:user) { create(:user, email: 'a034506618@gmail.com', password: '111aa111') }

    it "password match" do    
      expect(User.login('a034506618@gmail.com', '111aa111')).to eq(user)
    end

    it "password not match" do
      expect(User.login('a034506618@gmail.com', 'xxxxx')).to be_nil
    end
  end
  
end
