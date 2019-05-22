class BusinessSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :address,
             :email,
             :phone_number

  attribute :distributor do |object|
    object.distributor
  end

  attribute :representative do |object|
    object.rep
  end

end
