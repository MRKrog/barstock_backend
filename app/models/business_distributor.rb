class BusinessDistributor
  attr_reader :id,
              :name,
              :address

  def initialize(distributor)
    @id = distributor.id
    @name = distributor.name
    @address = distributor.address
  end


end
