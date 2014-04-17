class FeedbacksController < ApplicationController

	def index
		
		if(current_user.in_committee?("IT"))
			@feedbacks = Feedback.all.desc(:created_at).to_a
		else
			@feedbacks = current_user.feedbacks.desc(:created_at).to_a
		end

	end

	def show
		@feedback = Feedback.find(params[:id])
		render :partial => 'details'
	end

	def create
		#@user = User.find(params[:task][:responsible_user_id])
		@feedback = Feedback.new params[:feedback]
		@feedback.user = current_user
		if @feedback.save
			redirect_to feedbacks_path
		else
			redirect_to :back, alert: @feedback.errors.full_messages.join("\n")
		end
   	end

   	def update
   		@feedback = Feedback.find(params[:id])
		if @feedback.update_attributes!(params[:feedback])
			redirect_to feedbacks_path
		else
			redirect_to :back, alert: @feedback.errors.full_messages.join("\n")
		end
   	end

   	def destroy
   		@feedback = Feedback.find(params[:id])
   		@feedback.destroy
   		redirect_to feedbacks_path
   	end

end
