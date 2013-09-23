class UsersController < ApplicationController

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
				format.html { redirect_to @user, notice: 'User was sucessfull created'}
			else 
				format.html { render action: "new"} 
			end
		end
	end

	def update 
	end

	def destroy 
	end



end
