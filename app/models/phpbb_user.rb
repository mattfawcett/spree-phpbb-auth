class PhpbbUser < ActiveRecord::Base
  handles_connection_for "phpbb_database_#{RAILS_ENV}"
  set_primary_key "user_id"

end

