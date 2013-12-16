class AuthenticationsController < ApplicationController
  
  def create
    client = GOOGLE
    auth_token = client.auth_code.get_token(
    params[:code], redirect_uri: GOOGLE_REDIRECT_URI)
    session = GoogleDrive.login_with_oauth(auth_token.token)
    @files = session.files
  end
end