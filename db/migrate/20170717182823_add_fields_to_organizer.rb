class AddFieldsToOrganizer < ActiveRecord::Migration[5.1]
  def change
  	add_column :organizers, :first_name, :string
  	add_column :organizers, :last_name, :string
  end
end
