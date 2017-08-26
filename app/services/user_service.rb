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
		@user_interests = create_user_interests
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



	private

	def user_params
		# Receiving user params in `user` param key.
		params.require(:user).permit(:email,:password)
	end

	def tag_params
		# Receiving tag ids in `tag_ids` array param key.
		params.require(:tag_ids)
	end

	def create_user
		#Building user
		User.new(user_params)
	end

	def create_picture
		#Building user picture
		@new_user.build_picture(avatar: @params[:picture][:avatar],imageable: @new_user)
	end

	def create_user_interests
		# Building interests of user
		@new_user.tags << TagService.new(tag_params).get_tags_by_ids
	end



end
