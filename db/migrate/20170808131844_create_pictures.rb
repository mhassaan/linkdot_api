class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :imageable_type
      t.integer :imageable_id
			t.attachment :avatar
      t.timestamps
    end
  end
end
