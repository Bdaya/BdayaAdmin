class Admin::UsersController < ApplicationController
  
  before_filter :authenticate_admin!

  before_filter :init_user, except: [:index, :new, :create]

  

  def new
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def create
  end

  def show
  end

  private

  def init_user
    @user = User.find params[:id]
  end

end
