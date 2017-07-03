class RenamePostItPostId < ActiveRecord::Migration[5.1]
  def change
  	rename_column :comments, :post_it, :post_id
  end
end
