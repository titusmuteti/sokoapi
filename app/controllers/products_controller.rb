class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy ]

  def index
    products = Product.all
  end

  def show
  end

  # def new
  #   @product = Product.new
  # end

  def edit
  end

  # POST /prdestroy
  # def create
  #   @produdestroy

  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_product
    #   @product = Product.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, :description, :category, :image, :rating)
    end
end
