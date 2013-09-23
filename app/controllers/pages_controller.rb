require 'net/https'

class PagesController < ApplicationController
  def home
  	@count = User.count 
  	if (@count > 1)
	  	id_1 = rand(1..@count)
	  	id_2 = rand(1..@count)
	  	while (id_2 == id_1)
	  		id_2 = rand(1..@count)
	  	end

	  	@user_1 = User.find(id_1)
	  	@user_2 = User.find(id_2)
	  	@user_img_1 = getPhotoUri(@user_1)
	  	@user_img_2 = getPhotoUri(@user_2)
	end
  	respond_to do |format|
  		format.html # home.html.erb
  		format.js {} # to ajax 
  	end
  end

  def about

  	 respond_to do |format|
  		format.html # home.html.erb
  		format.js {} # to ajax 
  	end
  end


  def getPhotoUri(user) 
  	uri = URI.parse("https://api.vk.com/method/users.get")
  	params = {:user_ids => user.user_id, :fields => :photo_200_orig }
  	uri.query = URI.encode_www_form(params)
  	res = Net::HTTP.get_response(uri)
  	js = JSON.parse(res.body)
  	photo_uri = js["response"][0]["photo_200_orig"]
  end

end
