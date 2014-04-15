class AdminController < ApplicationController
  layout 'admin/master'
  
  before_filter :authenticate_admin!

end