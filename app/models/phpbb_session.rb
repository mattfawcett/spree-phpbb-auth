class PhpbbSession < ActiveRecord::Base
  handles_connection_for "phpbb_database_#{RAILS_ENV}"
  def self.table_name() "#{PHPBB_AUTH_FORUM_DATABASE_TABLE_PREFIX}sessions" end

  belongs_to :phpbb_user, :foreign_key => :session_user_id
  
  def logged_in?
    session_user_id > 1  
  end
  
end
