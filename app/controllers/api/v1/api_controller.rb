module Api
	module V1
		class ApiController < ApplicationController

		before_action :require_login!

		def user_signed_in?
			current_user.present?
		end

		def require_login!
			return true if authenticate_token
			render json: { errors: [ { detail: "Access denied" } ] }, status: 401
		end

		def current_user
			@current_user ||=authenticate_token
		end

		private 
			def authenticate_token
				authenticate_with_http_token do |token, options|
					User.where(auth_token: token).where("auth_token_created_at >= ?",1.hour.ago).first
				end
			end
		end
	end
end		

