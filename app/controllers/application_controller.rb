class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
	protected
	  def authenticate_inviter!
	  	if(!(current_user && current_user.head_of_committee != nil))
	  		redirect_to root_url
	  	end
	  end
end
