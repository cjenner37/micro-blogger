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
	@current_user = current_user
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
	puts User.create(params[:user])
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
	# @user = User.first # this is temporary, we should be using the line above
	@user_posts = @user.posts
	@post_count = @user.posts.length
	@comment_count = @user.comments.length

	erb :profile
end

get '/feed' do
	erb :feed
end