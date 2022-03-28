
# TODO: Implement #done
class StoresController < ApplicationController
  before_action :set_variable, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.get_data(params)
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @store.assign_attributes(store_params)
    if @store.save
      redirect_to stores_path
    else
      flash[:error] = @store.errors.full_messages.join(', ')
      render :new
    end
  end

  private
    def set_variable
      @store = Store.find(params[:id])
      @products = Product.where(store_id: @store.id)
      @review = Review.get_data(params)
    end

    def store_params
      params.require(:store).permit!
    end
end
