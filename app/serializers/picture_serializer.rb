class PictureSerializer < ActiveModel::Serializer
  attributes :id,:image
	belongs_to :imageable, polymorphic: true
	def image
		Figaro.env.base_url+'/public'+object.avatar.url
	end
end
