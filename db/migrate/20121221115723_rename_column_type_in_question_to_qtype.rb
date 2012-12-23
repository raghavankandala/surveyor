class RenameColumnTypeInQuestionToQtype < ActiveRecord::Migration
  def up
  	rename_column "questions", "type", "qtype"
  end

  def down
  	rename_column "questions", "qtype", "type"
  end
end
