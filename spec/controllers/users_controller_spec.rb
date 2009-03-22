require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  before(:each) do
    request.env["HTTP_REFERER"] = "http://myshop.com/myproduct"   
    empty_tables
  end
  
  it "should redirect me to the forum signup when I hit action login and pass on the referer" do    
    get :new    
    response.should redirect_to("#{PHPBB_AUTH_FORUM_REGISTER_URL}&redirect=http://myshop.com/myproduct")
  end
  
  it "should redirect me to the my account area of the forum if I click the edit me details link" do
    phpbb_user = PhpbbUser.create(valid_PhpbbUser_attributes)
    phpbb_session = PhpbbSession.create!(valid_PhpbbSession_attributes(:session_user_id => phpbb_user.user_id))
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "2d4b5dd208b7baa6d548aea9d655b392"
    User.should_receive(:find_by_email).and_return(mock_user)
    User.should_receive(:find).with("12").and_return(mock_user)
    get :edit, :id => 12
    response.should redirect_to("#{PHPBB_AUTH_FORUM_MYACCOUNT_URL}&redirect=http://myshop.com/myproduct&sid=2d4b5dd208b7baa6d548aea9d655b392")
  end
    
end
