class CommitteesController < ApplicationController

	def new
		@committee = Committee.new
	end

	def create
		@committee = Committee.create!(params[:committee])

		redirect_to action: 'index'
	end

	def index
		@committee = Committee.all.to_a
	end
end
