class FeedbacksController < ApplicationController

	def index
		@feedbacks = Feedback.all.to_a
	end

	def show
		@feedback = Feedback.find(params[:id])
		render :partial => 'details'
	end
end
