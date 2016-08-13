require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "704b6c07ae9446508303849832107be0", "a5e4ad0bf7fd41b58ff649ca9ab5be18", scope: 'playlist-read-private playlist-read-collaborative playlist-modify-public playlist-modify-private'
end
