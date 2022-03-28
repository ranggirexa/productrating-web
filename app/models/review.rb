# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  comment     :string
#  rating      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  purchase_id :bigint
#
# Indexes
#
#  index_reviews_on_purchase_id  (purchase_id)
#
# Foreign Keys
#
#  fk_rails_...  (purchase_id => purchases.id)
#
class Review < ApplicationRecord
  belongs_to :purchase

  validates :rating, presence: true, numericality: { only_integer: true }
  validates :comment, presence: true

  validate :rating_within_limit

  def rating_within_limit
    # TODO: Implement validation logic for `rating` #done
    # - Rating cannot be greater than 5
    # - Rating cannot be a negative number
    # - Handle any potential error/crash
  	if self.rating <= 0 || self.rating > 5
  		errors.add(:base, "Rating should be 1 until 5")
  	end
  end

  def self.get_data(params = {})
    product_query = "and products.id = #{params[:product_id]}" if params[:product_id].present?

    Review.where(
      "true #{product_query}
      ").left_joins(purchase: [:product]).distinct
  end
end
