class PictureSerializer < ActiveModel::Serializer
  attributes :id,:image
	belongs_to :imageable, polymorphic: true
	def image
		object.avatar.url
	end
end
