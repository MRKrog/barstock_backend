class RepresentativeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :email,
             :phone_number

end
