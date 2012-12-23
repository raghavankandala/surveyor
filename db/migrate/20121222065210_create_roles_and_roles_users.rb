class CreateRolesAndRolesUsers < ActiveRecord::Migration
  def up
  	create_table :roles do |t|
  		t.string :name, :limit => "20"
  		t.timestamps
  	end

  	create_table :roles_users do |t|
  		t.belongs_to :role
  		t.belongs_to :user 
  		t.timestamps
  	end
  end

  def down
  	drop_table :roles
  	drop_table :roles_users
  end
end
