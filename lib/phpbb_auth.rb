module PhpbbAuthLib
  require "config/phpbbauth_settings"
  
  def run_phpbb_auth
    if cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"].nil?
      self.current_user = :false
    else
      @phpbb_session = PhpbbSession.find_by_session_id(cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"])
      if @phpbb_session.nil? || !@phpbb_session.logged_in?
        self.current_user = :false        
      else
        self.current_user = User.find_by_email(@phpbb_session.phpbb_user.user_email)       
        if self.current_user == :false
          # We don't have the user registered in the shopping cart database, lets  create them
          self.current_user = User.create!(:email => @phpbb_session.phpbb_user.user_email, :password => 'not_used', 
                                           :password_confirmation => 'not_used', :role => Role.find_by_name('user'))
        end
      end
    end
  end
end