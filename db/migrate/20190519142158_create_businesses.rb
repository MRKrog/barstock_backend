class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext'

    create_table :businesses do |t|
      t.references :distributor, foreign_key: true
      t.string :name
      t.text :address
      t.citext :email
      t.integer :phone_number
      t.string :password_digest
      t.text :api_key

      t.timestamps
    end
  end
end
