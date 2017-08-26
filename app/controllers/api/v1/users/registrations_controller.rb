module Api
  module V1
    module Users
      class RegistrationsController < ApiController
<<<<<<< HEAD
				# wrap_parameters format: [:json, :xml, :url_encoded_form, :multipart_form]
				# wrap_parameters User, include: [:email, :password]
				# wrap_parameters Organizer, include: [:first_name, :last_name]
				# wrap_parameters Picture, include: [:avatar]
=======
>>>>>>> stage
        skip_before_action :require_login!, only: [:create]

        def create
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
