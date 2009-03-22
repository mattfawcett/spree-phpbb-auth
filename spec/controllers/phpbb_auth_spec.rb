require File.dirname(__FILE__) + '/../spec_helper'


describe "PhpbbAuthLib" do
  controller_name "products"
  
  before(:each) {empty_tables}
  
  it "should create a new user when we hit the cart for the first time when logged into phpbb" do    
    phpbb_user = PhpbbUser.create(valid_PhpbbUser_attributes)
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => phpbb_user.user_id))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    
    lambda do
      get :index 
    end.should change(User, :count).by(1)
    
    User.find(:last).email.should eql("mail@nospam.co.uk")
  end
  
  it "should not create a user if I am not logged into the forum" do
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => 1))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    
    lambda do
      get :index 
    end.should_not change(User, :count)
  end
  
  it "should not create a user if 1 already exists with that email" do
    phpbb_user = PhpbbUser.create(valid_PhpbbUser_attributes)
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => phpbb_user.user_id))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    User.should_receive(:find_by_email).and_return(mock_user)
    lambda do
      get :index 
    end.should_not change(User, :count)
  end
  
  it "should log me in if I am logged in on the phpbb site and already registed" do
    phpbb_user = PhpbbUser.create(valid_PhpbbUser_attributes)
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => phpbb_user.user_id))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    User.should_receive(:find_by_email).and_return(mock_user)
    get :index
    session[:user_id].should eql(12)
  end
  
  it "should log me in if I am logged in on the phpbb site and have just been added to the shopping cart database" do
    phpbb_user = PhpbbUser.create(valid_PhpbbUser_attributes)
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => phpbb_user.user_id))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    get :index 
    session[:user_id].should eql(User.last.id)
  end
  
  it "should log me out if I am not logged in on the phpbb site" do
    request.cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    session[:user_id] = 10
    get :index 
    session[:user_id].should be_nil
  end
  
  it "should log me out if I there is no cookie" do
    session[:user_id] = 10
    get :index 
    session[:user_id].should be_nil
  end

end