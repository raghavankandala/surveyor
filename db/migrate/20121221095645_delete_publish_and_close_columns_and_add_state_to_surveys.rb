class DeletePublishAndCloseColumnsAndAddStateToSurveys < ActiveRecord::Migration
  def up
  	add_column "surveys", "state", :string, :limit => 20, :default => "Draft"
  	add_column "surveys", "published_at", :timestamp
  	remove_column "surveys", "published"
  	remove_column "surveys", "closed"
  end

  def down
  	add_column "surveys", "published", :boolean
  	add_column "surveys", "closed", :boolean
  	remove_column "surveys", "state"
  	remove_column "surveys", "published_at"
  end
end
