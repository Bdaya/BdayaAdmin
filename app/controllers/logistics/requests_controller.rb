class Logistics::RequestsController < ApplicationController

	def index
		@users = User.all.to_a
		@request_meetings = Request.where(request_type: 'room').asc(:created_at).to_a
		@request_permissions = Request.where(request_type: 'permissions').asc(:created_at).to_a
		@request_materials = Request.where(request_type: 'materials').asc(:created_at).to_a

	end

	def update
		@request = Request.find(params[:id])
		if @request.update_attributes(params[:request])
			@request.status = "Done"
			@request.save
			redirect_to(:action=>'index')
     	else
        	redirect_to(:action=>'index',noites: "Faild to Update")
     	end
	end
	
	private #-----------------------------------------------


end
