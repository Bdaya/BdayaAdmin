class UsersController < ApplicationController

  def home
    client = GOOGLE_CLIENT
    @auth_url = client.auth_code.authorize_url(
    redirect_uri: GOOGLE_REDIRECT_URI,
    scope:
        "https://docs.google.com/feeds/ " +
        "https://docs.googleusercontent.com/ " +
        "https://spreadsheets.google.com/feeds/")
  end


end