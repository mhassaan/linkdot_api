class TagService

	attr_accessor :params

	def initialize(params)
		@params = params
	end

	def create_tag
		@tag = new_tag
		error_messages = {}
		if @tag.valid?
			@tag.save
			@tag
		else
			error_messages = @tag.errors.full_messages
			{'errors': error_messages}
		end
	end

	def get_tags_by_ids
		tag_ids = Tag.where(id: @params.to_unsafe_h.values)
	end


	def get_tag_by_id
		tag_id = Tag.where(id: @params).first
	end

	def remove_tag
		#tag = Tag.find(@params)
		#tag.destroy
	end

	private
	def tag_params
		@params.require(:tag).permit(:name)
	end

	def new_tag
		tag = Tag.new(tag_params)
	end

	def self.get_all_tags
		tags = Tag.all
	end

end
