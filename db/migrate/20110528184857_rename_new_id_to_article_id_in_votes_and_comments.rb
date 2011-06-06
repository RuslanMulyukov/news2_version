class RenameNewIdToArticleIdInVotesAndComments < ActiveRecord::Migration
  def self.up
    rename_column :votes, :new_id, :article_id
    rename_column :comments, :new_id, :article_id
  end

  def self.down
    rename_column :votes, :article_id, :new_id
    rename_column :comments, :article_id, :new_id
  end
end
