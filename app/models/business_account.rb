class BusinessAccount
  attr_reader :id,
              :name,
              :address,
              :email,
              :phone_number

  def initialize(business, distributor, rep)
    @id = business.id
    @name = business.name
    @address = business.address
    @email = business.email
    @phone_number = business.phone_number
    @distributor_address = distributor.address
    @distributor_name = distributor.name
    @rep_name = rep.name
    @rep_email = rep.email
    @rep_phone_number = rep.phone_number
  end

  def distributor
    { distributor_address: @distributor_address, distributor_name: @distributor_name}
  end

  def rep
    { rep_name: @rep_name, rep_email: @rep_email, rep_phone_number: @rep_phone_number }
  end


end
