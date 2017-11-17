class PictureSerializer < ActiveModel::Serializer
  attributes :id,:image
	belongs_to :imageable, polymorphic: true
	def image
    if Figaro.application.environment.eql?("development")
		   Figaro.env.base_url+object.avatar.url
    else
      Figaro.env.base_url+'/public'+object.avatar.url
    end

	end
end
