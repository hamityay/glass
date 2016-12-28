class StocksController < ApplicationController
  before_action :authorize_user!, except: [:index]
  before_action :set_stock, only: [:edit, :update, :destroy]

  def index
    @search = Stock.all.order(id: :desc).search(params[:q])
    @stocks = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@stocks)
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new
    if @stock.update(stock_params)
      flash[:success] = 'Stok başarılı bir şekilde Kaydedildi'
      redirect_to stocks_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @stock.update(stock_params)
      flash[:success] = 'Stok başarılı bir şekilde güncellendi'
      redirect_to stocks_path
    else
      render 'edit'
    end
  end

  def destroy
    @stock.destroy
    flash[:success] = 'Tedarikçi başarılı bir şekilde silindi'
    redirect_to stocks_path
  end

  private
    def authorize_user!
      redirect_to root_path, notice: "Not authorized" unless user_signed_in?
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:dimensions, :count, :product_id, :suplier_id)
    end

end
