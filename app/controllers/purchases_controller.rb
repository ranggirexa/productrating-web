class PurchasesController < ApplicationController
  before_action :set_variables, only: [:show, :edit, :update, :destroy, :new, :create]

  def new
      @purchase = @product.purchases.new
  end

  def create
    @purchase = @product.purchases.new
    # TODO: Also decrease product quantity. #done
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
    # TODO: Show edit form #done
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to product_url(@product)
    else
      @method = "PUT"
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    # TODO: Delete record #done
    @purchase.destroy
    redirect_to product_url(@product), danger: 'Deleted'
  end

  def show
  end

  private
    def set_variables
      @product = Product.find(params[:product_id]) if params[:product_id].present?
      @purchase = Purchase.find(params[:id]) if params[:id].present?
    end

    def purchase_params
      params.require(:purchase).permit!
    end
end
