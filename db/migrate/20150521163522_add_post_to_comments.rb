class AddPostToComments < ActiveRecord::Migration
  def up
    add_reference :comments, :post, index: true, foreign_key: true
  end

  def down
  	remove_reference :comments, :post
  end
end
