class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  before_filter :authenticate_user!
  def index
    @ideas = Idea.where(type: 'idea').desc(:created_at).to_a
  end

  def top
    @ideas = Idea.where(type: 'idea').desc(:upvotes).to_a
    render 'index'
  end

  def top_gowanyat
    @ideas = Idea.where(type: 'gowanyah').desc(:upvotes).to_a
    render 'gowanyat'
  end

  def gowanyat
    @ideas = Idea.where(type: 'gowanyah').desc(:created_at).to_a
  end  

  def show
    @idea = Idea.find(params[:id])
    render :partial => 'details'
  end

  def create
    @idea = Idea.new(params[:idea])
    @idea.creator = current_user
    @idea.upvotes = 0

     if (@idea.save)
	    if (@idea.type == "idea")
	      redirect_to ideas_path
	    elsif (@idea.type == "gowanyah")
	      redirect_to gowanyat_path
	    end  
	 else  
	      redirect_to :back, alert: @idea.errors.full_messages.join("\n")
    end
  end

  def update
    @idea = Idea.find(params[:id])

     if (@idea.update_attributes!(params[:idea]))
	    if (@idea.type == "idea")
	      redirect_to ideas_path
	    elsif (@idea.type == "gowanyah")
	      redirect_to gowanyat_path
	    end  
	 else  
	      redirect_to :back, alert: @idea.errors.full_messages.join("\n")
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    itype = @idea.type
    @idea.destroy
    if (itype == "idea")
        redirect_to ideas_path
      elsif (itype == "gowanyah")
        redirect_to gowanyat_path
      end  
  end

  def upvote
   @idea = Idea.find(params[:id])
   if(@idea.upvoters.include?(current_user))
     @idea.upvotes = @idea.upvotes - 1
     @idea.save
     @idea.upvoters.delete(current_user)
   else
    @idea.upvotes = @idea.upvotes + 1
    @idea.save
    @idea.upvoters << current_user
     
   end 
   itype = @idea.type
   if (itype == "idea")
        redirect_to ideas_path
      elsif (itype == "gowanyah")
        redirect_to gowanyat_path
      end  
  end  

  def send_message
      @idea = Idea.find(params[:id])
      @user = current_user.name
      @message = params[:message]
      @idea.post_message(@user,@message)
      itype = @idea.type
     if (itype == "idea")
          redirect_to ideas_path
        elsif (itype == "gowanyah")
          redirect_to gowanyat_path
        end 
  end

end