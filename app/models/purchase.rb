# == Schema Information
#
# Table name: purchases
#
#  id               :bigint           not null, primary key
#  delivery_address :string
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint
#
# Indexes
#
#  index_purchases_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Purchase < ApplicationRecord
  belongs_to :product
  has_many :reviews

  validates :quantity, presence: true, numericality: {less_than_or_equal_to: :stock_available, only_integer: true }
  validates :delivery_address, presence: true

  def stock_available
    sold = Purchase.where(product_id: self.product_id).sum(:quantity)
    quantity = Product.where(id: self.product_id).sum(:quantity)
    stock_available = quantity.to_i - sold.to_i
    return stock_available
  end

  # TODO: Implement this logic
  # - Return true if a review for this purchase exists in the database
  # - Return false otherwise
  def review_exist?
    false
  end
end
