require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

	test "should_not_save_survey_without_a_title" do
		survey = Survey.new 
		assert !survey.save
	end

	test "should_not_save_survey_without_a_slug" do
		survey = Survey.new 
		assert !survey.save
	end

	test "should_not_save_survey_without_summary" do
		survey = Survey.new 
		assert !survey.save
	end

	test "should_not_mass_assign_published_flag" do
		exception = assert_raise(ActiveModel::MassAssignmentSecurity::Error) do 
			survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars", :published => true})
		end	
		assert_equal("Can't mass-assign protected attributes: published", exception.message)
	end

	test "should_not_mass_assign_closed_flag" do
		exception = assert_raise(ActiveModel::MassAssignmentSecurity::Error) do 
			survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars", :closed => true})
		end
		assert_equal("Can't mass-assign protected attributes: closed", exception.message)
	end

	test "should_not_publish_without_atleast_one_question" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		survey.save
		survey.publish!
		assert !survey.published 
	end

	test "valid_survey" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		assert survey.save 
	end

	test "valid_survey_to_publish" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		survey.questions.build({:title => "Which is the hottest hatchback?", :type => "Text"})
		survey.save
		survey.publish!
		assert survey.published
	end

end