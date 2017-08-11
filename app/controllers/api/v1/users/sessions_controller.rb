module Api
  module V1
    module Users
      class SessionsController < ApiController

        before_action :sign_in_params, only: [:create]
        skip_before_action :require_login!, only: [:create]

        def create
          user = User.find_by_email(sign_in_params[:email])

					if user.present?
						if user.valid_password?(sign_in_params[:password])
	            auth_token = user.generate_auth_token
	            render json: user
	          else
							invalid_login_attempt
	          end
					else
						account_does_not_exist
					end


        end

        def destroy
          resource = current_user
          resource.invalidate_auth_token
          render json: 'Sign Out Successfully.'
        end

        def sign_in_params
          params.require(:user).permit(:email,:password)
        end

        def invalid_login_attempt
          render json: {errors:[{detail: "Error with your password."}]}
        end

				def account_does_not_exist
					render json: {errors:[{detail: "Account does not exist. Please sign up to continue."}]}
				end

      end
    end
  end
end
