class CreateUsersPostsCommentsTables < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
  		t.string :first_name
  		t.string :last_name
  		t.string :email
  		t.string :password
  	end

  	create_table :posts do |t|
  		t.string :title
  		t.string :content
  		t.integer :user_id
  	end

  	create_table :comments do |t|
  		t.string :content
  		t.integer :user_id
  		t.integer :post_it
  	end
  end
end

