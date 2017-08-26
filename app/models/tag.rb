class Tag < ApplicationRecord
	validates :name, presence: true
	has_many :user_taggings
	has_many :users, through: :user_taggings

	has_many :event_taggings
	has_many :events, through: :event_taggings
end
