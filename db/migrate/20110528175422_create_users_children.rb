class CreateUsersChildren < ActiveRecord::Migration
  def self.up
    create_table :users_children do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :users_children
  end
end
