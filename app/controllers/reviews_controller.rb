class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create]

  def new
    @review = Review.new(purchase_id: @purchase_id)

  end

  def create
    # TODO: Create the record in database #done
    @review = Review.new(review_params)
    @review.assign_attributes(review_params)
    if @review.save
      redirect_to product_purchase_url(id: @review.purchase_id, product_id: @review.purchase.product_id)
    else
      flash[:error] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_variables
      @purchase_id = params[:review][:purchase_id] if params[:review].present? && params[:review][:purchase_id].present?
    end

    def review_params
      params.require(:review).permit!
    end
end
