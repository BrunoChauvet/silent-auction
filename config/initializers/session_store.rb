# Be sure to restart your server when you modify this file.

SilentAuction::Application.config.session_store :cookie_store, {
	:key =>           '_ufe_session_id',
  :path =>          '/',
  :domain =>        nil,
  :expire_after =>  nil,
  :secure =>        false,
  :httponly =>      true,
  :cookie_only =>   true
}
