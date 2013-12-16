class UsersController < ApplicationController

  def home
    client = OAuth2::Client.new(
    GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET,
    site: "https://accounts.google.com",
    token_url: "/o/oauth2/token",
    authorize_url: "/o/oauth2/auth")
    @auth_url = client.auth_code.authorize_url(
    redirect_uri: GOOGLE_REDIRECT_URI,
    scope: GOOGLE_SCOPES)
  end


end