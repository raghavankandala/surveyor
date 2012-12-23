class SurveysController < ApplicationController
	before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :responses]
	load_and_authorize_resource
	before_filter :find_survey, :except => [:new, :create, :index]

	def new
		@survey = Survey.new
	end

	def create
		@survey = Survey.new(params[:survey])
		if @survey.save
			redirect_to @survey, :notice => "Survey created!"
		else
			render :action => 'new'
		end
	end

	def show
		@response = @survey.responses.build()
		@response.user = current_user
	end

	def index
		if current_user && current_user.role?(:admin)
			@surveys = Survey.page(params[:page] || 1).per(10)
		else
			@surveys = Survey.published.page(params[:page] || 1).per(10)
		end
	end

	def destroy
		if @survey.destroy
			redirect_to root_url, :notice => "Survey deleted!"
		else
			redirect_to root_url, :error => "Sorry! Survey cannot be deleted!"
		end
	end

	def edit
	end

	def update
		if @survey.update_attributes(params[:survey])
			flash[:notice] = "Survey updated!"
		else
			flash[:error] = "Can not update the Survey! Please try again later!"
		end
		redirect_to @survey
	end

	def publish
		unless @survey.publish!
			flash[:error] = "Cannot publish this Survey without Questions!"
		end
	end

	def close
		@survey.close!
		respond_to do |format|
			format.js { render 'publish' }
		end
	end

	def draft
		@survey.draft!
		respond_to do |format|
			format.js { render 'publish' }
		end
	end

	def responses
		@responses = @survey.responses
	end

	protected

		def find_survey
			@survey = Survey.find(params[:id])
		end

end