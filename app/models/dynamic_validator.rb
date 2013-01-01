class DynamicValidator < ActiveModel::Validator

  def validate(record)

    # 1. Lets check if all the questions have been answered
  	record.data.values.each do |answer|
  		if answer.blank?
  			record.errors[:base] << "Please answer all the questions"
  			return;
  		end
  	end

  	# 2. Lets check if the valid answers are provided based on the question type
  	# Date and Number

  	record.data.each_pair do |question_id, answer|
  		q = Question.find(question_id)
  		case (q.qtype)
  		when 'Date'
  			begin
  				d = Date.strptime(answer, "%d-%m-%Y")
  			rescue
  				record.errors[:base] << "#{q.title} => Date entered is invalid"
  			end
  		when 'Number'
  			record.errors[:base] << "#{q.title} ==> Please enter only numeric answer." unless is_number(answer)
  		when 'Text'
  		when 'One Line'
  			record.errors[:base] << "#{q.title} ==> Answer should not exceed 250 characters" unless answer.length <= 250
  		when 'Paragraph'
  		end
  	end
 end


protected 

	def is_number(number_string)
		number_string.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end

end