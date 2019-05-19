class BusinessItem < ApplicationRecord
  belongs_to :business
  belongs_to :item
end
