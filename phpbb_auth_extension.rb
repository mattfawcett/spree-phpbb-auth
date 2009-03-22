# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'


class PhpbbAuthExtension < Spree::Extension
  version "1.0"
  description "Use an existing phpBB installation as your login/authenticaton mechanism"
  url "http://matthewfawcett.co.uk"
  
  

  # Please use php_bb_auth/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
    
  end
  
  ApplicationController.class_eval do
    require "lib/phpbb_auth"
    include PhpbbAuthLib
    before_filter :run_phpbb_auth      
  end
  
  UsersController.class_eval do
    include PhpbbAuthHelper
    def new
      redirect_to(prepare_phpbb_url(PHPBB_AUTH_FORUM_REGISTER_URL))
    end
    def edit
      redirect_to(prepare_phpbb_url(PHPBB_AUTH_FORUM_MYACCOUNT_URL))
    end
  end
  
  AccountController.class_eval do
    include PhpbbAuthHelper
    def login
      redirect_to(prepare_phpbb_url(PHPBB_AUTH_FORUM_LOGIN_URL))
    end
    
    def logout
      redirect_to(prepare_phpbb_url(PHPBB_AUTH_FORUM_LOGOUT_URL))
    end
  end
  

end