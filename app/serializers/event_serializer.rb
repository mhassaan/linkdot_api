class EventSerializer < ActiveModel::Serializer
  attributes :id,:title,:address,:city,:state,:zip,:event_start_time,:event_end_time,:event_start_date,:event_end_date
	has_one :picture, as: :imageable, dependent: :destroy
	has_many :tags, through: :event_taggings

	def event_start_time
		object.start_time.strftime("%H:%S %p")
	end

	def event_end_time
		object.end_time.strftime("%H:%S %p")
	end

	def event_start_date
		object.start_date.strftime("%m-%d-%Y")
	end

	def event_end_date
		object.end_date.strftime("%m-%d-%Y")
	end

end
