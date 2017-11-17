class UserService
	attr_accessor :params
	attr_reader :organizer, :new_user, :user_pic
	def initialize(params)
		@params = params
	end

	def create_user!
		error_messages = {}
		@new_user = create_user
		@user_pic = create_picture
		if params[:tag_ids].present?
			@user_interests = create_user_interests
		end
		if @new_user.valid? && @user_pic.valid?
			@new_user.save
			@new_user
		else
			[@new_user,@user_pic].each do |item|
				unless item.valid?
					error_messages[item.class.name] = item.errors.full_messages
				end
			end
			{'errors'=>error_messages}
		end
	end

	# def update_user!(user)
	# 	error_messages = {}
	# 	user_updated = user.update_attributes(user_params) if params[:user].present?
	# 	pic_updated = user.picture.update_attributes(picture_params) if params[:picture].present?
	# 	interests_updated = update_user_interests(user) if params[:tag_ids].present?
  #
	# 	if user.errors.present? || user.picture.errors.present?
	# 		error_messages[user.class.name] = user.errors.full_messages if user.errors.present?
	# 		error_messages[user.picture.class.name] = user.picture.errors.full_messages if user.picture.errors.present?
	# 		{'errors' => error_messages }
	# 	else
	# 		user.save
	# 		user
	# 	end
	# end

	def update_user!(user)
		error_messages = {}

		user_updated = user.update_attributes(update_user_params) if params[:user].present?
		if update_user_params[:password].blank?
      update_user_params.delete(:password)
      update_user_params.delete(:password_confirmation) if update_user_params[:password_confirmation].blank?
			user_updated = user.update_attributes(update_user_params)
			user.clean_up_passwords
		else
			if update_user_params[:password_confirmation].blank?
				error_messages[user.class.name] = "Password confimration is needed to reset password."
			else
				unless (update_user_params[:password].eql?(update_user_params[:password_confirmation]))
					error_messages[user.class.name] = "Password & password confimration does not match."
				end
			end
    end

		user_pic = user.build_picture(avatar: params[:picture][:avatar],imageable: user) if params[:picture].present?
		interests_updated = update_user_interests(user) if params[:tag_ids].present?
		if user_pic.present?
			unless user_pic.valid?
				error_messages[user.picture.class.name] = user_pic.errors.full_messages
			end
		end

		unless user_updated
			error_messages[user.class.name] = user.errors.full_messages if user.errors.present?
		end

		if error_messages.present?
			{'errors' => error_messages }
		else
			user.save!
			user
		end

	end

	private

	def user_params
		# Receiving user params in `user` param key.
		params.require(:user).permit(:email,:password,:first_name,:last_name,:password_confirmation)
	end

	def update_user_params
		# Receiving user params in `user` param key.
		params.require(:user).permit(:email,:password,:first_name,:last_name,:password_confirmation,:current_password)
	end

	def tag_params
		# Receiving tag ids in `tag_ids` array param key.
		params.require(:tag_ids)
	end

	def picture_params
		params.require(:picture).permit(:avatar)
	end

	def create_user
		#Building user
		User.new(user_params)
	end

	def create_picture
		#Building user picture
		@new_user.build_picture(avatar: @params[:picture][:avatar],imageable: @new_user)
	end

	def update_picture(user)
		user.build_picture(avatar: @params[:picture][:avatar],imageable: user)
	end

	def create_user_interests
		# Building interests of user
		tag_params.each do |index,tag_id|
			unless @new_user.user_taggings.where(tag_id: tag_id).first.present?
				@new_user.tags << TagService.new(tag_id).get_tag_by_id
			end
		end
	end

	def update_user_interests user
		# Building interests of user
		tag_params.each do |index,tag_id|
			if user.user_taggings.where(tag_id: tag_id).first.present?
				user.user_taggings.where(tag_id: tag_id).first.destroy
			end
		end
	end



end
