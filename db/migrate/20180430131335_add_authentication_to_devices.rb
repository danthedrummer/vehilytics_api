class AddAuthenticationToDevices < ActiveRecord::Migration[5.1]
  def change
    add_column :devices, :authentication_token, :string, limit: 30
    add_index :devices, :authentication_token, unique: true
  end
end
