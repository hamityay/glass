class WelcomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category).all
  end
end