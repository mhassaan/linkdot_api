class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token
  #attribute :authentication_token, if: :authentication_token
  belongs_to :meta, polymorphic: true
	has_one :picture, as: :imageable,dependent: :destroy

  def authentication_token
  	object.auth_token
  end

end
