class CreateDistributors < ActiveRecord::Migration[5.2]
  def change
    create_table :distributors do |t|
      t.text :address
      t.string :name
      t.string :distributor_code
      t.text :api_key

      t.timestamps
    end
  end
end
