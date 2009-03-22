require File.dirname(__FILE__) + '/../spec_helper'

describe AccountController do
  before(:each) do
    cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"] = "123456789"
    request.env["HTTP_REFERER"] = "http://myshop.com/myproduct"   
  end
   
  it "should redirect me to the forum login when I hit action login and pass on the refferer" do    
    get :login    
    response.should redirect_to("#{PHPBB_AUTH_FORUM_LOGIN_URL}&redirect=http://myshop.com/myproduct&sid=123456789")
  end
  
  it "should redirect me to the forum logout when I hit action login and pass on the refferer" do    
    get :logout    
    response.should redirect_to("#{PHPBB_AUTH_FORUM_LOGOUT_URL}&redirect=http://myshop.com/myproduct&sid=123456789")
  end

end
