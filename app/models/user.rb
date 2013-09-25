require 'net/https'
require 'UserValidator'
class User < ActiveRecord::Base
	attr_accessible :user_id, :firstName, :lastName 
	validates :user_id, :uniqueness => true
	validates_with UserValidator
	before_validation :get_name_and_last_name_of_user


	private 
		def get_name_and_last_name_of_user() 
			names = send_request_and_get_names(self)
			self.firstName = names[0]
			self.lastName = names[1]
			self.user_id = names[2]

		end 

		def send_request_and_get_names(user)
			uri = URI.parse('https://api.vk.com/method/users.get')	
			params = {:user_ids => user.user_id, :v => "5.2"}
			uri.query = URI.encode_www_form(params)
			res = Net::HTTP.get_response(uri)
			js = JSON.parse(res.body)
			[js["response"][0]["first_name"], js["response"][0]["last_name"], js["response"][0]["id"]]
		end


end





