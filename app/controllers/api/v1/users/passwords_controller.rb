module Api
  module V1
    module Users
      class PasswordsController < ApiController
        skip_before_action :require_login!, only: [:create,:edit,:update]

        def create
          user = User.where(password_params).first
          if user.present?
            #raw_token,hashed_token = user.set_reset_password_token
            hashed_token = user.set_reset_password_token
            UserMailer.sent_reset_password_instructions(user,hashed_token).deliver
            render json: user
          else
          end
        end

        def edit 
          user = User.find_by_reset_password_token(params[:token])
          if user.exists?
            render json: user
          else
            render json: 'Token Expired.'
          end
        end

        def update 
          user = User.find_by_reset_password_token(params[:token]).reset_password(params[:user][:new_password],params[:new_password_confirmation])
        byebug
          render json: user
        end

        def password_params
          params.require(:user).permit(:email)
        end

        # The path used after sending reset password instructions
        # def after_sending_reset_password_instructions_path_for(resource_name)
        #   if is_navigational_format?
        #     new_session_path(resource_name)
        #   else
        #     # Do nothing?
        #   end
        # end

      end
    end
  end
end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
