class OrderAddress

  include ActiveModel::Model
  attr_accessor :post_code, :ship_from_id, :city, :address, :building_name, :tel_num, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :city
    validates :address
    validates :tel_num, format: {with: /\A[0-9]{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :ship_from_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(post_code: post_code, ship_from_id: ship_from_id, city: city, address: address, building_name: building_name, tel_num: tel_num, order_id: order.id)
  end
end