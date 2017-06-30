require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'sinatra/flash'

enable :sessions
set :database, 'sqlite3:blog.sqlite3'

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

get '/' do
	@current_user = current_user
	erb :home
end

get '/new_user' do
	erb :new_user
end

post '/new_user' do
	User.create(params[:user])
	redirect '/'
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
		redirect '/'
	else
		flash[:alert] = "There was a problem. Please try again!"
		redirect '/login'
	end
end

post '/logout' do
	session[:user_id] = nil
	redirect '/'
end