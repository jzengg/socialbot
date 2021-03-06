class ProductsController < ApplicationController
  before_action :require_login
  before_action :require_unpublished, only: [:update]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_url
    else
      flash.now[:danger] = "Error saving product"
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "Updated product"
      redirect_to products_url
    else
      flash.now[:danger] = "Error updating product"
      # can show product errors for better message
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = "Removed product"
    redirect_to products_url
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :url)
  end

  def require_unpublished
    product = Product.find(params[:id])
    if product.published
      flash[:danger] = "Cannot edit a product that has already been published"
      redirect_to products_url
    end
  end
end
