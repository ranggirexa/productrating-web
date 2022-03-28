class ProductsController < ApplicationController
  before_action :set_variable, only: [:show, :edit, :update, :destroy, :new]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
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
    def set_variable
      @product = Product.get_data(id: params[:id]) if !@product.present?
      @review = Review.get_data(product_id: @product.first.id) if @product.present?
      @store = Store.get_data(params)
    end

    def product_params
      params.require(:product).permit!
    end
end
