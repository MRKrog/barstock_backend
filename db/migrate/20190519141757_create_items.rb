class CreateItems < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext'

    create_table :items do |t|
      t.references :distributor, foreign_key: true
      t.citext :name
      t.string :alc_type
      t.string :alc_category
      t.float :price
      t.float :ounces
      t.string :unit
      t.string :thumbnail
      t.integer :quantity

      t.timestamps
    end
  end
end
