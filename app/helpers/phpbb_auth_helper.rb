module PhpbbAuthHelper

  def prepare_phpbb_url(url)
    redirect_url = "#{url}&redirect=#{request.referer}"
    redirect_url << "&sid=#{cookies[PHPBB_AUTH_COOKIE_NAME + "_sid"]}" unless cookies["#{PHPBB_AUTH_COOKIE_NAME}_sid"].nil?
    return redirect_url
  end
end