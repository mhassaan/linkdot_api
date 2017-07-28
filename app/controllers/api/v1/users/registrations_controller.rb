module Api
  module V1
    module Users
      class RegistrationsController < ApiController

        skip_before_action :require_login!, only: [:create]

        def create 
          organizer = new_organizer
          new_user = organizer.build_user(email: params[:user][:email],password: params[:user][:password],meta: organizer)
          if new_user.save
            if organizer.save
              render json: organizer
            else
              render json: organizer.errors.full_messages
            end
          else
            render json: new_user.errors.full_messages
          end

        end
        
        protected

        def organizer_params
          params.require(:organizer).permit(:first_name,:last_name)
        end

        def new_organizer
          Organizer.new(organizer_params)
        end

      end
    end
  end
end

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
