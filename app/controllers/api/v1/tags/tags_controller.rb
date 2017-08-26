module Api
	module V1
		module Tags
			class TagsController < ApiController
				skip_before_action :require_login!, only: [:create,:index]

				def index
					tags = TagService.get_all_tags
					render json:tags
				end

				def create
					tag = TagService.new(params).create_tag
					render json:tag
				end

				def event_tags
				end

				def user_tags
				end


			end
		end
	end
end
