class DistributorSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :address

end
