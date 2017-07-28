class AddAuthTokenCreatedAtToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :auth_token, :string
    add_column :users, :auth_token_created_at, :string
    add_index :users, [:auth_token, :auth_token_created_at]
  end
end
