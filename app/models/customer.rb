class Customer < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :name, :address, :province, :city, :postal_code, presence: true
end
