class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :new_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
