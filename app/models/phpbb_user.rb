class PhpbbUser < ActiveRecord::Base
  handles_connection_for "phpbb_database_#{RAILS_ENV}"
  def self.table_name() "#{PHPBB_AUTH_FORUM_DATABASE_TABLE_PREFIX}users" end
  set_primary_key "user_id"
end

