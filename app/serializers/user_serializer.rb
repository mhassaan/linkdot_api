class UserSerializer < ActiveModel::Serializer
<<<<<<< HEAD
  attributes :id, :email, :authentication_token
  #attribute :authentication_token, if: :authentication_token
  belongs_to :meta, polymorphic: true
=======
  attributes :id, :email
  attribute :authentication_token, if: :authentication_token
  #belongs_to :meta, polymorphic: true
>>>>>>> stage
	has_one :picture, as: :imageable,dependent: :destroy
	has_many :tags, through: :user_taggings

  def authentication_token
<<<<<<< HEAD
  	object.auth_token
=======
  	token = (object.auth_token?)? object.auth_token : nil
>>>>>>> stage
  end

end
