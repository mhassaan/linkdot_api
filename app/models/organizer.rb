class Organizer < ApplicationRecord
	has_one :user, as: :meta, dependent: :destroy
	validates_presence_of :first_name, :last_name

end
