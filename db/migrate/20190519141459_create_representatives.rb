class CreateRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :representatives do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.references :distributor, foreign_key: true

      t.timestamps
    end
  end
end
