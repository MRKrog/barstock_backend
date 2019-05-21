class BusinessItemInfo
  attr_reader :alc_type,
              :id,
              :alc_category,
              :thumbnail,
              :price_sold,
              :serving_size,
              :quantity

  def initialize(business_item, item)
    @alc_type = item.alc_type
    @alc_category = item.alc_category
    @thumbnail = item.thumbnail
    @id = business_item.id
    @price_sold = business_item.price_sold
    @serving_size = business_item.serving_size
    @quantity = business_item.quantity
  end

end
