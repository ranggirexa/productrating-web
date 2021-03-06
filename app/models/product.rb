# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :decimal(, )
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint
#
# Indexes
#
#  index_products_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Product < ApplicationRecord
  has_many :purchases, dependent: :destroy
  belongs_to :store

  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  validate :quantity_within_limit

  def quantity_within_limit
    return unless quantity

    if quantity < 0
      errors.add(:quantity, 'too few')
    end
  end

  def self.get_data(params = {})
    product_query = "and products.id = #{params[:id]}" if params[:id].present?

    Product.where(
      "true #{product_query}
      ").left_joins(:store, purchases: [:reviews]).distinct
  end

end
