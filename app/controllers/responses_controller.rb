class ResponsesController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource

	def new
		@survey = Survey.find(params[:survey_id])
		unless current_user.taken?(@survey)
			@response = @survey.responses.build({:user_id => current_user.id})
		else
			@response = @survey.response(current_user)
		end
	end
	
	def create
		@response = Response.new(params[:response])
		@survey = @response.survey
		if @response.save
			redirect_to root_url, :notice => "Thanks for taking the Survey"
		else
			render :action => 'new'
		end
	end

	def index
		@survey = Survey.find(params[:survey_id])
		@responses = @survey.responses.page(params[:page] || 1).per(5)
	end
end