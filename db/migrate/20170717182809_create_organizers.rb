class CreateOrganizers < ActiveRecord::Migration[5.1]
  def change
    create_table :organizers do |t|

      t.timestamps
    end
  end
end
