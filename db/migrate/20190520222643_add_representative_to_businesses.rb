class AddRepresentativeToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_reference :businesses, :representative, foreign_key: true
  end
end
