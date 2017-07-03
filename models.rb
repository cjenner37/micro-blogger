class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	def full_name
		first_name + ' ' + last_name
	end
end

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
end

class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end