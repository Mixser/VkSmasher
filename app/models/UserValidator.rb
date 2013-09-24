
	class UserValidator < ActiveModel::Validator

		def validate(record) 
			if not user_validate(record) 
				record.errors[:base] << "Vk not have user with this id's or nick name!!!"
			end
		end

		def user_validate(record)
			js = send_request_to_vk_and_get_json_response(record)
			js["error"].nil?
		end


		def send_request_to_vk_and_get_json_response(user)
			uri = URI.parse('https://api.vk.com/method/users.get')
			params = {:user_ids => user.user_id }
			uri.query = URI.encode_www_form(params)
			res = Net::HTTP.get_response(uri)
			js = JSON.parse(res.body)
		end
	end
