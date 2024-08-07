class Cart < ApplicationRecord
  has_one :order
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.increment(:quantity)
    else
      current_item = line_items.build(product: product, quantity: 1)
    end
    current_item.save
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
