class UsersController < ApplicationController

  def home
    client = GOOGLE_CLIENT
    @auth_url = client.auth_code.authorize_url(
    redirect_uri: GOOGLE_REDIRECT_URI,
    scope: GOOGLE_SCOPES)
  end


end