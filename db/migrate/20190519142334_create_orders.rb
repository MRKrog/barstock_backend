class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :business, foreign_key: true
      t.float :total_cost
      t.float :total_revenue

      t.timestamps
    end
  end
end
