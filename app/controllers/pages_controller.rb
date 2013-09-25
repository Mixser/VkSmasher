require 'net/https'

class PagesController < ApplicationController
  def home
    catch_exception do 
  	 @users = User.find(:all, :limit => 2, :order => "RANDOM()")
     @photos = [getPhotoUri(@users[0]), getPhotoUri(@users[1])]
    end
    
  	
  end

  def about

  	 respond_to do |format|
  		format.html # home.html.erb
  		format.js {} # to ajax 
  	end
  end


  private  
  
  def getPhotoUri(user) 
    if (not user.nil?)
      uri = URI.parse("https://api.vk.com/method/users.get")
      params = {:user_ids => user.user_id, :fields => :photo_200_orig, :access_token => session[:access_token] }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      js = JSON.parse(res.body)
      photo_uri = js["response"][0]["photo_200_orig"]
    end
  end

  def catch_exception(&block) 
    begin 
      yield
      rescue ActiveRecord::RecordNotFound
        flash[:error] = 'Cound find a user, sorry =('
        redirect_to root_path
      rescue Exception
        flash[:error] = 'Very bad =('
        redirect_to root_path
    end
  end

  

end
