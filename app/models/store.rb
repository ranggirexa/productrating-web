# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Store < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true

  def self.get_data(params = {})
    product_query = "and products.id = #{params[:product_id]}" if params[:product_id].present?

    Store.where(
      "true #{product_query}
      ").left_joins(products: [:purchases]).distinct
  end
end
