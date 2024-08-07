class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :line_items, through: :cart

  validates :total_amount, presence: true
  validates :user_id, presence: true

  # Add this method to allow searching through these associations
  def self.ransackable_associations(auth_object = nil)
    ["cart", "user"]
  end

  # Add this method to allow specific attributes to be searchable
  def self.ransackable_attributes(auth_object = nil)
    ["total_amount", "address", "province", "street", "payment_status", "payment_id", "created_at"]
  end
end
