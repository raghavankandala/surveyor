class AddOrderToQuestions < ActiveRecord::Migration
  def up
  	add_column "questions", "qorder", :integer
  end

  def down
  	remove_column "questions", "qorder"
  end
end
