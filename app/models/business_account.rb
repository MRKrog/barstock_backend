class BusinessAccount
  attr_reader :id,
              :name,
              :address,
              :email,
              :phone_number

  def initialize(business)
    @id = business.id
    @name = business.name
    @address = business.address
    @email = business.email
    @phone_number = business.phone_number
  end


end
