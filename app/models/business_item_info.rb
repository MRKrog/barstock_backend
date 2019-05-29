class BusinessItemInfo
  attr_reader :alc_type,
              :item_name,
              :id,
              :alc_category,
              :thumbnail,
              :price_sold,
              :serving_size,
              :quantity,
              :item_id

  def initialize(business_item, item)
    @item_name = item.name
    @alc_type = item.alc_type
    @alc_category = item.alc_category
    @thumbnail = item.thumbnail
    @id = business_item.id
    @price_sold = business_item.price_sold
    @serving_size = business_item.serving_size
    @quantity = business_item.quantity
    @item_id = item.id
  end

end
