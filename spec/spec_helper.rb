unless defined? SPREE_ROOT
  ENV["RAILS_ENV"] = "test"
  case
  when ENV["SPREE_ENV_FILE"]
    require ENV["SPREE_ENV_FILE"]
  when File.dirname(__FILE__) =~ %r{vendor/SPREE/vendor/extensions}
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
  else
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
  end
end
require "#{SPREE_ROOT}/spec/spec_helper"

if File.directory?(File.dirname(__FILE__) + "/scenarios")
  Scenario.load_paths.unshift File.dirname(__FILE__) + "/scenarios"
end
if File.directory?(File.dirname(__FILE__) + "/matchers")
  Dir[File.dirname(__FILE__) + "/matchers/*.rb"].each {|file| require file }
end

Spec::Runner.configure do |config|
  # config.use_transactional_fixtures = true
  # config.use_instantiated_fixtures  = false
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures'

  # You can declare fixtures for each behaviour like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so here, like so ...
  #
  #   config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
end

def mock_user
  mock_model(User, :id => 12, :email => "mail@nospam.co.uk")
end

def empty_tables
  PhpbbSession.delete_all
  PhpbbUser.delete_all
end

#Note: canot use fixtures easily as they try to use the normal database instead of the phpBB specific database
def valid_PhpbbSession_attributes(overwrite_attributes = {})
  {
    :session_last_visit => "1236865629",
    :session_browser => "Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.5) Gecko/2008121621 Ubuntu/8.04 (hardy) Firefox/3.0.5",
    :session_start => "1236865629",
    :session_time => "1236865629",
    :session_id => "2d4b5dd208b7baa6d548aea9d655b392",
    :session_viewonline => "1",
    :session_ip => "127.0.0.1",
    :session_admin => "0",
    :session_page => "../index.php",
    :session_forum_id => "0",
    :session_forwarded_for =>  "",
    :session_autologin => "0",
    :session_user_id => "1",
  }.merge(overwrite_attributes)
end
def valid_PhpbbUser_attributes(overwrite_attributes = {})
  {
    :user_id => 2, 
    :user_type => 3,
    :group_id => 10, 
    :user_permissions => "zik0zjzik0zjzik0w0\nzik0zi000000\nzik0zi000000\nzik0zi...", 
    :user_perm_from => 0, 
    :user_ip => "", 
    :user_regdate => 1170504862, 
    :username => "matt", 
    :username_clean => "matt", 
    :user_password => "$H$93xTU0YcEwMg2lkx5nN84UYbchanged", 
    :user_passchg => 0, 
    :user_pass_convert => false, 
    :user_email => "mail@nospam.co.uk", 
    :user_email_hash => -136655181925, 
    :user_birthday => "0- 0-   0", 
    :user_lastvisit => 1219841542, 
    :user_lastmark => 1212931539, 
    :user_lastpost_time => 1219997228, 
    :user_lastpage => "", 
    :user_last_confirm_key => "4KK3B3FD3P", 
    :user_last_search => 1214674888, 
    :user_warnings => 0, 
    :user_last_warning => 0, 
    :user_login_attempts => 0, 
    :user_inactive_reason => 0, 
    :user_inactive_time => 0, 
    :user_posts => 50, 
    :user_lang => "en", 
    :user_timezone => 1, 
    :user_dst => false,
    :user_dateformat => "d M Y h:i a", 
    :user_style=> 1, 
    :user_rank => 1, 
    :user_colour => "AA0000", 
    :user_new_privmsg => 0, 
    :user_unread_privmsg => 0, 
    :user_last_privmsg => 1213370330, 
    :user_message_rules => false, 
    :user_full_folder => -3, 
    :user_emailtime => 1212924689, 
    :user_topic_show_days => 0, 
    :user_topic_sortby_type => "t", 
    :user_topic_sortby_dir => "d", 
    :user_post_show_days => 0,
    :user_post_sortby_type => "t", 
    :user_post_sortby_dir => "a", 
    :user_notify => false, 
    :user_notify_pm => true, 
    :user_notify_type => 0, 
    :user_allow_pm => true, 
    :user_allow_viewonline => true, 
    :user_allow_viewemail => true, 
    :user_allow_massemail => true, 
    :user_options => 1919, 
    :user_avatar => "", 
    :user_avatar_type => 0, 
    :user_avatar_width => 0, 
    :user_avatar_height => 0, 
    :user_sig => "some sig", 
    :user_sig_bbcode_uid => "39nm3i65", 
    :user_sig_bbcode_bitfield => "IA==", 
    :user_from => "Leeds", 
    :user_icq => "", 
    :user_aim => "", 
    :user_yim => "", 
    :user_msnm => "", 
    :user_jabber => "", 
    :user_website => "http://matthewfawcett.co.uk", 
    :user_occ => "", 
    :user_interests => "", 
    :user_actkey => "", 
    :user_newpasswd => "", 
    :user_form_salt => "af92d6547f0009e2"
  }
end