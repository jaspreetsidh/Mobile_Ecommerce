ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image, :category_id

  form html: { multipart: true } do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :image, as: :file
      f.input :category, as: :select, collection: Category.all.map { |c| [c.name, c.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :category
      row :image do |product|
        image_tag url_for(product.image), size: '200x200' if product.image.attached?
      end
    end
    active_admin_comments
  end
end
