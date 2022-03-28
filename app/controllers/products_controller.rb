class ProductsController < ApplicationController
  # before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # before_action do
  #   case action_name.to_sym
  #   when :new, :create
  #     @product = Product.new
  #   when :show, :edit, :update, :destroy
  #     @product = Product.get_data(id: params[:id])
  #   end
  # end

  def new
    @product = Product.new
  end

  def create
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to products_url
    else
      flash[:error] = @product.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
  end

  def index
    @products = Product.get_data(params)
  end

  private
    def set_product
      @product = Product.get_data(id: params[:id]) if !@product.present?
    end

    def product_params
      params.require(:product).permit(:name, :quantity, :price)
    end
end
