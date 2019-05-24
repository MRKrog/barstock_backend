class CreateDistributors < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'citext'

    create_table :distributors do |t|
      t.text :address
      t.citext :name
      t.citext :distributor_code
      t.text :api_key

      t.timestamps
    end
  end
end
