module Api
	module V1
		module Events
			class EventsController < ApiController
				skip_before_action :require_login!, only: [:create]

				def index
					events = EventService.get_all_events
					render json: events
				end

				def create
					event = EventService.new(params).create_event!
					render json: event
				end
			end
		end
	end
end
