class UsersController < ApplicationController
 # before_filter :authenticate_user!
  def home
    client = GOOGLE_CLIENT
    @auth_url = client.auth_code.authorize_url(
    redirect_uri: GOOGLE_REDIRECT_URI,
    scope:
        "https://docs.google.com/feeds/default/private/ " +
        "https://docs.google.com/feeds/ " +
        "https://docs.googleusercontent.com/ " +
        "https://spreadsheets.google.com/feeds/")
  end

  def index 
    @users = User.all.to_a 
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        redirect_to action:'index' , noitce: "User Created succssfully"
    else
        render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def filter_users_project
    @users = User.all.where()
    render 'new'
  end

  def filter_users_commitee
    @users = User.all.where()
    render 'new'
  end

end