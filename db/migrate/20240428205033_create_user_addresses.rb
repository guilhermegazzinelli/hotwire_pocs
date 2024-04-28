class CreateUserAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_addresses do |t|
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :other
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
