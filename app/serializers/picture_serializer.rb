class PictureSerializer < ActiveModel::Serializer
  attributes :id,:image
	belongs_to :imageable, polymorphic: true
	def image
<<<<<<< HEAD
		Figaro.env.base_url+'/public'+object.avatar.url
=======
		#Rails.root.join('/',object.avatar.url)
		Figaro.env.base_url+object.avatar.url
>>>>>>> stage
	end
end
