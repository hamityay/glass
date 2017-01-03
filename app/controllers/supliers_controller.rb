class SupliersController < ApplicationController
  before_action :authorize_user!, except: [:index]
  before_action :set_suplier, only: [:edit, :update, :destroy]

  def index
    @search = Suplier.all.order(id: :desc).search(params[:q])
    @supliers = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@osupliers)
  end

  def new
    @suplier = Suplier.new
  end

  def create
    @suplier = Suplier.new
    if @suplier.update(suplier_params)
      flash[:success] = 'Tedarikçi başarılı bir şekilde kaydedilmiştir'
      redirect_to supliers_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @suplier.update(suplier_params)
      flash[:success] = 'Tedarikçi başarılı bir şekilde güncellendi'
      redirect_to supliers_path
    else
      render 'edit'
    end
  end

  def destroy
    @suplier.destroy
    flash[:success] = 'Tedarikçi başarılı bir şekilde silindi'
    redirect_to supliers_path
  end

  private

    def authorize_user!
      redirect_to root_path, notice: "Not authorized" unless user_signed_in?
    end

    def set_suplier
      @suplier = Suplier.find(params[:id])
    end

    def suplier_params
      params.require(:suplier).permit(:name, :phone_number, :agent_name)
    end
end
