class Picture < ApplicationRecord
	belongs_to :imageable, polymorphic: true
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment :avatar, presence: true,content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

	#Method that clears duplicate error messages from paperclip.
	after_validation :clean_paperclip_errors

	def clean_paperclip_errors
		errors.delete(:avatar)
	end

end
