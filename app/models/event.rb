class Event < ApplicationRecord
	validates :title, presence: true
	has_one :picture, as: :imageable, dependent: :destroy
	has_many :event_taggings
	has_many :tags, through: :event_taggings

end
