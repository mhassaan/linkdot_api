module Api
  module V1
    module Users
      class RegistrationsController < ApiController
				# wrap_parameters format: [:json, :xml, :url_encoded_form, :multipart_form]
				# wrap_parameters User, include: [:email, :password]
				# wrap_parameters Organizer, include: [:first_name, :last_name]
				# wrap_parameters Picture, include: [:avatar]
        skip_before_action :require_login!, only: [:create]

        def create
					user = UserCreationService.new(params).create_user!
					render json: user
        end

      end
    end
  end
end
#curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{"organizer": {"first_name":"Larry", "last_name":"King"},"user": {"email":"m@mail.com", "password":"12345678"}}' http://165.227.70.44/users/sign_up

#localhost:3000/users/sign_up?organizer[first_name]=Marta&&organizer[flast_name]=Giovi&&user[email]=giovi@mail.com&&user[password]=12345678
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
