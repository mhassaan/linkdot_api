class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def sent_reset_password_instructions user, hashed_token
		@user = user
    	@token  = hashed_token
    	mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end
end
