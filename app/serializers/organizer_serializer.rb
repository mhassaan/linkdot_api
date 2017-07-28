class OrganizerSerializer < ActiveModel::Serializer
  attributes :id, :full_name
  has_one :user, as: :meta, dependent: :destroy
  
  def full_name
  	object.first_name+' '+ object.last_name 
  end

end
