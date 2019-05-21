class ChangePhoneNumberInBusinessToBigInt < ActiveRecord::Migration[5.2]
  def change
    remove_column :businesses, :phone_number, :integer
    add_column :businesses, :phone_number, :bigint
  end
end
