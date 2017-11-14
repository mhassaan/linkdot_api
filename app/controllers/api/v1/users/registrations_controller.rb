module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        skip_before_action :require_login!, only: [:create]

        def create
          puts params
					if params[:picture].present?
						user = UserService.new(params).create_user!
						render json: user
					else
						render json: {errors:[{Picture: "Please select an image to complete registration."}]}
					end
        end

      end
    end
  end
end
