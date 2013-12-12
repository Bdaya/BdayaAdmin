class Logistics::RequestsController < ApplicationController

	def index
		@request = Request.all.asc(:created_at).to_a
	end

	def update
		@request = Request.find_by(params[:req])
		if @request.update_attributes(params[:request])
			@request.status = "done"
			@request.save
			redirect_to(:action=>'index')
     	else
        	redirect_to(:action=>'index',noites: "Faild to Update")
     	end
	end
	
	private #-----------------------------------------------


end
