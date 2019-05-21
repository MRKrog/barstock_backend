class BusinessRepresentative
  attr_reader :id,
              :name,
              :email,
              :phone_number

  def initialize(representative)
    @id = representative.id
    @name = representative.name
    @email = representative.email
    @phone_number = representative.phone_number
  end


end
