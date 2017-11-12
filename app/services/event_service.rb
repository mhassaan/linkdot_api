class EventService

	attr_accessor :params
	attr_reader :event, :event_picture

	def initialize(params)
		@params = params
	end

	def self.get_all_events
		events = Event.find_by_sql("SELECT * from `events` where start_date IS NOT NULL and end_date IS NOT NULL and start_time IS NOT NULL and end_time IS NOT NULL")
	end

	def create_event!
		error_messages = {}
		@event = new_event
		@event_picture = new_event_picture
		@event_tags = create_event_tags
		if @event.valid? && @event_picture.valid?
			@event.save
			@event
		else
			[@event,@event_picture].each do |inst|
				error_messages[inst.class.name] << inst.error.full_messages
			end
			{'errors'=>error_messages}
		end
	end

	private

	def format_date(date)
		Date.strptime(date,"%m-%d-%Y")
	end

	def format_time(time)
		DateTime.strptime(time,"%I:%M %p")
	end

	def tag_params
		params.require(:tag_ids)
	end

	def create_event_tags
		@event.tags << TagService.new(tag_params).get_tags_by_ids
	end

	def new_event
		Event.new(title: params[:event][:title],address: params[:event][:address],city: params[:event][:city],state: params[:event][:state],zip: params[:event][:zip],
							start_date: format_date(params[:event][:start_date]),end_date: format_date(params[:event][:end_date]),start_time: format_time(params[:event][:start_time]),
							end_time: format_time(params[:event][:end_time]))
	end

	def new_event_picture
		@event.build_picture(avatar: params[:picture][:avatar], imageable: @event)
	end

end
