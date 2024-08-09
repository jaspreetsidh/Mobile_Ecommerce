require 'faker'


# Seed products for Mobiles category
30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 200.0..1500.0),
    category: mobiles_category
  )
end

# Seed products for Accessories category
30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 5.0..100.0),
    category: accessories_category
  )
end

# Seed products for Audio category
30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 50.0..500.0),
    category: audio_category
  )
end

# Seed products for Powerbank category
30.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 20.0..100.0),
    category: powerbank_category
  )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

StaticPage.find_or_create_by(title: "Contact") do |page|
  page.content = "This is the contact page content."
end

StaticPage.find_or_create_by(title: "About") do |page|
  page.content = "This is the about page content."
end
