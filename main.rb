require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'sinatra/flash'

enable :sessions
set :database, 'sqlite3:boatblog.sqlite3'

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

get '/' do
	@user = current_user
	erb :home
end

post '/' do
	User.create(params[:user])
	redirect '/profile'
end

get '/new_user' do
	erb :new_user
end

post '/new_user' do
	@user = User.create(params[:user])
	session[:user_id] = @user.id
	redirect '/profile'
end

get '/login' do
	erb :login
end

post '/login' do
	@user = User.where(email: params[:email]).first
	if @user and @user.password == params[:password]
		# log in the user
		session[:user_id] = @user.id
		flash[:notice] = "You've been signed in!"
		redirect '/profile'
	else
		flash[:alert] = "There was a problem. Please try again!"
		redirect '/'
	end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end

get '/profile' do
	@user = current_user

	@user_posts = @user.posts
	@post_count = @user.posts.length
	@comment_count = @user.comments.length

	erb :profile
end

get '/feed' do
	@user = current_user
	@posts = @user.posts.last(10).reverse
	erb :feed
end

post '/feed' do
	@user = current_user
	@user.posts.create(params[:post])
	redirect '/feed'
end


post '/edit_profile' do
	@user = current_user
	@new_first_name = params[:update_first_name]
	@new_last_name = params[:update_last_name]
	@new_email = params[:update_email]
	@new_password = params[:update_password]

	if !@new_first_name.nil? or @new_first_name != ""
		@user.first_name = @new_first_name
	end

	if !@new_last_name.nil? or @new_last_name != ""
		@user.last_name = @new_last_name
	end

	if !@new_email.nil? or @new_email != ""
		@user.email = @new_email
	end

	if !@new_password.nil? or @new_password != ""
		@user.password = @new_password
	end

	@user.save
	redirect '/profile'

end


post '/search_users' do
	@search_term = params[:name]
	@results = User.where('first_name LIKE ?', '%' + @search_term + '%')

	erb :search_results, layout: false
end