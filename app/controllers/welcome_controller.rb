class WelcomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all
  end
end