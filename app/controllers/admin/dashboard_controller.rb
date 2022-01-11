class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: "Jungle", password: "book"
  before_filter :authorize

  def cool
  end

  def free
  end


  def show
    @products = Product.count
    @categories = Category.count
  end
end
