class AuthenticationsController < ApplicationController
  
  def create
    client = OAuth2::Client.new(
    GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET,
    site: "https://accounts.google.com",
    token_url: "/o/oauth2/token",
    authorize_url: "/o/oauth2/auth")
    auth_token = client.auth_code.get_token(
    params[:code], redirect_uri: GOOGLE_REDIRECT_URI)
    session = GoogleDrive.login_with_oauth(auth_token.token)
    @files = session.files
  end
end