class ChangeDistributorCodeToCode < ActiveRecord::Migration[5.2]
  def change
    remove_column :distributors, :distributor_code, :citext
    add_column :distributors, :code, :citext
  end
end
