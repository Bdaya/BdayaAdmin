class UsersController < ApplicationController
  before_filter :authenticate_user!, :except=> [:search]
  def home
    client = GOOGLE_CLIENT
    @auth_url = client.auth_code.authorize_url(
    redirect_uri: GOOGLE_REDIRECT_URI,
    scope:
        "https://docs.google.com/feeds/default/private/ " +
        "https://docs.google.com/feeds/ " +
        "https://docs.googleusercontent.com/ " +
        "https://spreadsheets.google.com/feeds/")

    redirect_to meetings_path
  end

  def index 
    @users = User.all.asc(:name).to_a
  end


  def show
    @user = User.find(params[:id])
    @crit = @user.get_crit    #this will be used in a javascript file to show the graph like in show_evaluation page
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

    if @user.update_attributes(params[:user])
        redirect_to @user
      else
        redirect_to :back, alert: @user.errors.full_messages.join("\n")
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

  def set_evaluation
    @user = User.find(params[:id])
    @evaluations = @user.evaluations

    if @evaluations.count == 0
      @user = User.find(params[:id])
      @evaluation = @user.evaluations.build
    else
      time = ((Time.now - @evaluations.last.created_at)/(60*60*24)).to_i
      if(time > 14)
        @user = User.find(params[:id])
        @evaluation = @user.evaluations.build
      else
        render(:text => "Evaluation for this user is inaccessible right now! Only #{time} day(s) has passed.")
      end
    end
  end

  def save_evaluation
    @evaluation = Evaluation.new(params[:evaluation])
    # i think this is ineffiecient 5ales :D... i didn't find another way that works :D
     @c1 = params[:evaluation][:cri1].to_i
     @c2 = params[:evaluation][:cri2].to_i
     @c3 = params[:evaluation][:cri3].to_i
     @c4 = params[:evaluation][:cri4].to_i
     @c5 = params[:evaluation][:cri5].to_i
     @evaluation.cri1 = @c1
     @evaluation.cri2 = @c2
     @evaluation.cri3 = @c3
     @evaluation.cri4 = @c4
     @evaluation.cri5 = @c5

    if @evaluation.save
      redirect_to show_evaluation_user_path(@evaluation.user_id)
    else
      redirect_to :back, notice: "Sorry! Could Not save."
    end
  end

  def show_evaluation
    @user = User.find(params[:id])
    @evaluations = @user.evaluations
    @crit = @user.get_crit
  end

  # def assign_task
  #   @task = Task.new
  # end

  # def save_assign_task
  #   @user = User.find(params[:task][:user_id])
  #   @task = current_user.assign_task(@user, params[:task][:deadline], params[:task][:title], params[:task][:details])
  #   #@task.responsible_user = User.find(params[:task][:user_id])
  #   #@task.save
  #   redirect_to sent_tasks_path
  # end

  def update_image
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to root_path
  end

  def search
    query = params[:q]
    @users = []
    if query
      User.only(:name,:id).where(name: /#{query}/i).all.each do |user|
        unless (current_user && (current_user==user))
          unless (user.image.url == nil)
            @users << {id:user.id,name:user.name, image: user.image.url}
          else
            @users << {id:user.id,name:user.name, image: nil}
          end
        end
      end
    end
    render :partial => 'userSearch'
  end
end
