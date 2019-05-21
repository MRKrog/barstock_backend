class ChangePhoneNumberInDistributorToBigInt < ActiveRecord::Migration[5.2]
  def change
    remove_column :representatives, :phone_number, :integer
    add_column :representatives, :phone_number, :bigint
  end
end
