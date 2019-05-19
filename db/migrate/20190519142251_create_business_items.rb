class CreateBusinessItems < ActiveRecord::Migration[5.2]
  def change
    create_table :business_items do |t|
      t.references :business, foreign_key: true
      t.references :item, foreign_key: true
      t.float :price_sold
      t.integer :quantity
      t.float :serving_size

      t.timestamps
    end
  end
end
