class ResponsesController < ApplicationController
	
	def create
		@response = Response.new(params[:response])
		if @response.save
			redirect_to root_url, :notice => "Thanks for taking the Survey"
		else
			render :action => 'new'
		end
	end
end