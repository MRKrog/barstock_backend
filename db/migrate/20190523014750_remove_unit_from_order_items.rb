class RemoveUnitFromOrderItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_items, :unit, :string
  end
end
