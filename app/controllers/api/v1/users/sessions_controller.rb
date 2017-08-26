module Api
  module V1
    module Users
      class SessionsController < ApiController

        before_action :sign_in_params, only: [:create]
        skip_before_action :require_login!, only: [:create]

        def create
          user = User.find_by_email(sign_in_params[:email])
          if user.valid_password?(sign_in_params[:password])
            auth_token = user.generate_auth_token
            render json: user
          else
            invalid_login_attempt
          end
        end

        def destroy
					# Returns an Array of [String, Hash] if a token is present. Returns nil if no token is found.
					user_token = ActionController::HttpAuthentication::Token.token_and_options(request)[0]
					user = User.where(auth_token: user_token).first
          user.invalidate_auth_token
          render json: {detail:'Sign Out Successfully.'}
        end

        def sign_in_params
          params.require(:user).permit(:email,:password)
        end

        def invalid_login_attempt
          render json: {errors:[{detail: "Error with your login or password."}]}
        end

      end
    end
  end
end
