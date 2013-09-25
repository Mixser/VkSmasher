require 'net/https'
class UsersController < ApplicationController

	APP_ID = 2939839
	SECURE_KEY = "2kQbRkdVBZW0vT8dVjJM"

	def index 
		@users = User.all
	end


	def show 
		@user = User.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
		end
	end

	def new 
		@user = User.new 
		respond_to do |format|
			format.html # new.html.erb
		end
	end 

	def edit 

	end

	def create 
		@user = User.new(params[:user])

		respond_to do |format| 
			if @user.save 
				format.html { redirect_to pages_home_path, notice: 'User was sucessfull created'}
			else 
				format.html { redirect_to new_user_path, notice: 'User not be created!!! '} 
			end
		end
	end

	def update 
	end

	def destroy 
	end


	def session_auth
		session[:access_token] = getAccessToken(params[:code])
		respond_to do |format|
			format.html { redirect_to pages_home_path(:ac => session[:access_token]) }
			format.js { render :controller => :pages, action: "home"}
		end

	end


	private 
		def getAccessToken(code) 
			uri = URI.parse('https://oauth.vk.com/access_token')
			params = {:client_id => APP_ID, :client_secret => SECURE_KEY,
							  :code => code, :redirect_uri =>"http://localhost:3000/session_auth/"}
			uri.query = URI.encode_www_form(params)
			res = Net::HTTP.get_response(uri)
			js = JSON.parse(res.body)

			js["access_token"]
		end


end
