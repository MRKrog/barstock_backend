class BusinessSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :address,
             :email,
             :phone_number

end
