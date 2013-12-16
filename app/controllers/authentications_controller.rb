class AuthenticationsController < ApplicationController
  
  def create
    client = GOOGLE_CLIENT
    auth_token = client.auth_code.get_token(
    params[:code], redirect_uri: GOOGLE_REDIRECT_URI)
    session = GoogleDrive.login_with_oauth(params[:code])
    @files = session.files
  end
end