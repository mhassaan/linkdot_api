class UserSerializer < ActiveModel::Serializer

  attributes :id, :email
  attribute :authentication_token, if: :authentication_token
  #belongs_to :meta, polymorphic: true
	
	has_one :picture, as: :imageable,dependent: :destroy
	has_many :tags, through: :user_taggings

  def authentication_token
  	token = (object.auth_token?)? object.auth_token : nil
  end

end
