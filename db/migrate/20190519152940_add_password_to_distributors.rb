class AddPasswordToDistributors < ActiveRecord::Migration[5.2]
  def change
    add_column :distributors, :password_digest, :string
  end
end
