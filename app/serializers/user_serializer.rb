class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  attribute :authentication_token, if: :authentication_token?
  belongs_to :meta, polymorphic: true

  def authentication_token?
  	true if object.auth_token 
  end

end
