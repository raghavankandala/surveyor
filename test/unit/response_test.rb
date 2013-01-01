require 'test_helper'

class ResponseTest < ActiveSupport::TestCase

	test "should_not_save_response_without_all_answers" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		survey.questions.build({:title => "Which is the hottest hatchback?", :qtype => "Text"})
		survey.questions.build({:title => "How many cars do you own?", :qtype => "Number"})
		survey.questions.build({:title => "When did you buy your last car?", :qtype => "Date"})
		survey.save
		survey.publish!
		response = Response.new()
		response.survey = survey
		response.user = User.first
		response.data = {}
		survey.questions.collect {|q| response.data.store(q.id, "")}
		assert !response.save
	end

	test "should_not_save_response_if_number_type_questions_answer_is_not_a_number" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		q1 = survey.questions.build({:id => 1, :title => "Which is the hottest hatchback?", :qtype => "Text"})
		q2 = survey.questions.build({:id => 2, :title => "How many cars do you own?", :qtype => "Number"})
		q3 = survey.questions.build({:id => 3, :title => "When did you buy your last car?", :qtype => "Date"})
		survey.save
		survey.publish!
		response = Response.new()
		response.survey = survey
		response.user = User.first
		response.data = {}
		response.data.store(q1.id, "Fiat Grande Punto")
		response.data.store(q2.id, "abcd")
		response.data.store(q3.id, Date.today())
		assert !response.save
	end

	test "should_not_save_response_if_date_type_questions_answer_is_not_date" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		q1 = survey.questions.build({:id => 1, :title => "Which is the hottest hatchback?", :qtype => "Text"})
		q2 = survey.questions.build({:id => 2, :title => "How many cars do you own?", :qtype => "Number"})
		q3 = survey.questions.build({:id => 3, :title => "When did you buy your last car?", :qtype => "Date"})
		survey.save
		survey.publish!
		response = Response.new()
		response.survey = survey
		response.user = User.first
		response.data = {}
		response.data.store(q1.id, "Fiat Grande Punto")
		response.data.store(q2.id, "2")
		response.data.store(q3.id, "abcd")
		assert !response.save
	end

	test "Should_save_valid_response" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		q1 = survey.questions.build({:id => 1, :title => "Which is the hottest hatchback?", :qtype => "Text"})
		q2 = survey.questions.build({:id => 2, :title => "How many cars do you own?", :qtype => "Number"})
		q3 = survey.questions.build({:id => 3, :title => "When did you buy your last car?", :qtype => "Date"})
		survey.save
		survey.publish!
		response = Response.new()
		response.survey = survey
		response.user = User.first
		response.data = {}
		response.data.store(q1.id, "Fiat Grande Punto")
		response.data.store(q2.id, "2")
		response.data.store(q3.id, "1-1-2013")
		assert response.save
	end

	test "user_should_not_take_a_survey_more_than_once" do
		survey = Survey.new({:title => "About Cars", :slug => "about-cars", :summary => "This survey is about cars"})
		q1 = survey.questions.build({:id => 1, :title => "Which is the hottest hatchback?", :qtype => "Text"})
		q2 = survey.questions.build({:id => 2, :title => "How many cars do you own?", :qtype => "Number"})
		q3 = survey.questions.build({:id => 3, :title => "When did you buy your last car?", :qtype => "Date"})
		survey.save
		survey.publish!
		response = Response.new()
		response.survey = survey
		response.user = User.first
		response.data = {}
		response.data.store(q1.id, "Fiat Grande Punto")
		response.data.store(q2.id, "2")
		response.data.store(q3.id, "1-1-2013")
		response.save

		response1 = Response.new()
		response1.survey = survey
		response1.user = User.first
		response1.data = {}
		response1.data.store(q1.id, "Fiat Grande Punto")
		response1.data.store(q2.id, "2")
		response1.data.store(q3.id, "1-1-2013")
		assert !response1.save
		puts response1.errors.full_messages.collect { |m| m }
	end
	
end