class ProductsController < ApplicationController
  before_action :authorize_user!, except: [:index]
  before_action :set_product, only: [:edit, :update, :destroy]
  add_breadcrumb I18n.t('dock.dashboard'), :products_path

  def index

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    if @product.update(product_params)
      flash[:success] = 'Ürün başarılı bir şekilde kaydedilmiştir'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Ürün başarılı bir şekilde güncellendi'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    flash[:success] = 'Ürün başarılı bir şekilde silindi'
    redirect_to root_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :category_id)
    end

    def authorize_user!
      redirect_to root_path, notice: "Not authorized" unless user_signed_in?
    end
end
