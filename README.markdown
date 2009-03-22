= Phpbb Auth

This extension allows you to add a spree shopping cart installation to an existing site that uses phpbb as a central store for users and loggin in. 
Edit the config/phpbbauth_settings.rb file to define your settings. When a user browses to the cart, the extension checks to see if they have a 
phpbb session cookie. If so it looks them up in the phpbb database. If the spree database doesn't have a user with that email registered it will 
create one. It will then log the user into the spree site. Also if there is no phpbb session cookie or the there is but the user is not logged into 
phpbb, then they will be logged out of the spree site.

The login, register and logout actions of the spree site are overwritten to send the user to the phpbb equivalent.

