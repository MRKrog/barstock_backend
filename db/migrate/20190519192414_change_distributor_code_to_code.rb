class ChangeDistributorCodeToCode < ActiveRecord::Migration[5.2]
  def change
    remove_column :distributors, :distributor_code, :string
    add_column :distributors, :code, :string
  end
end
