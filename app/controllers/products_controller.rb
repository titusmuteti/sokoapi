class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: :ok
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: :ok
  end

  private
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, :description, :category, :image, :rating)
    end
end
