class StaticPage < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id title updated_at]
  end
end
