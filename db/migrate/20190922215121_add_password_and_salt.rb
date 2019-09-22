class AddPasswordAndSalt < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.column :encrypted_password, :string
      t.column :salt, :string
    end
  end
end
