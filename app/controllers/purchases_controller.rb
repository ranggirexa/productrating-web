class PurchasesController < ApplicationController
  before_action :set_variables, only: [:show, :edit, :update, :destroy, :new, :create]

  def new
      @purchase = @product.purchases.new
  end

  def create
      @purchase = @product.purchases.new
    # TODO: Also decrease product quantity.
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)
    @purchase.assign_attributes(purchase_params)
    if @purchase.save
      redirect_to product_url(@product)
    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # TODO: Show edit form
  end

  def update
    # TODO: Update record (save to database)
  end

  def destroy
    # TODO: Delete record
  end

  def show
  end

  private
    def set_variables
      params[:id] = params[:product_id] if !params[:id].present? && params[:product_id].present?
      @product = Product.find(params[:id])
      @purchase = @product.purchases.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end
