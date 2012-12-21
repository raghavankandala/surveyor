class CreateSurveysQuestionsAndResponses < ActiveRecord::Migration
  def up

    create_table :surveys do |t|
      t.string :title
      t.string :slug
      t.text :summary
      t.boolean :published
      t.boolean :closed
      t.timestamps
    end

    create_table :questions do |t|
      t.string :title
      t.string :type
      t.belongs_to :survey
      t.timestamps
    end

    create_table :responses do |t|
      t.belongs_to :survey
      t.belongs_to :user
      t.column :data, "hstore"
      t.timestamps
    end

  end

  def down
    drop_table :surveys
    drop_table :questions
    drop_table :responses
  end
end
