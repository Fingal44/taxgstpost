=begin
	
rescue Exception => e
	
end
describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end
=end
require 'spec_helper'
describe User do
  it "has a valid factory" do
    build(:user).should be_valid
  end
  it "is invalid without an email" do
    build(:user, email: nil).should_not be_valid
  end
end