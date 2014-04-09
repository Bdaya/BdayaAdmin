class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.where(type: 'idea').desc(:created_at).to_a
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
    @idea.user = current_user

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

  def up_vote (i)
   @idea = i 
   @idea.no_of_upvotes = @idea.no_of_upvotes + 1
   @idea.save
   redirect_to action: 'index'
  end  

end