class PictureSerializer < ActiveModel::Serializer
  attributes :id,:image
	belongs_to :imageable, polymorphic: true
	def image
		#Rails.root.join('/',object.avatar.url)
		Figaro.env.base_url+object.avatar.url
	end
end
