class Customer < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  # Consider relaxing some validations or providing default values
  validates :name, :address, :province, :city, :postal_code, presence: true
end
