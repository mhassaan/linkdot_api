class UserCreationService
	attr_accessor :params
	attr_reader :organizer, :new_user, :user_pic
	def initialize(params)
		@params = params
	end

	def create_user!
		error_messages = {}
		@organizer = create_organizer
		@new_user = create_user
		@user_pic = create_picture

		if @organizer.valid? && @new_user.valid? && @user_pic.valid?
			@organizer.save;@new_user.save;@user_pic.save
			@new_user
		else
			[@organizer,@new_user,@user_pic].each do |item|
				unless item.valid?
					error_messages[item.class.name] = item.errors.full_messages
				end
			end
			{'error_messages'=>error_messages}
		end
	end

	private

	def organizer_params
		@params.require(:organizer).permit(:first_name,:last_name)
	end

	def new_organizer
		Organizer.new(organizer_params)
	end

	def create_organizer
		new_organizer
	end

	def create_user
		@organizer.build_user(email: @params[:user][:email],password: @params[:user][:password],meta: @organizer)
	end

	def create_picture
		@new_user.build_picture(avatar: @params[:picture][:avatar],imageable: @new_user)
	end



end
