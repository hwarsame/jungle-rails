class Admin::CategoriesController < ApplicationController
  # http_basic_authenticate_with name: "Jungle", password: "book"
  
  before_filter :authorize

  def cool
  end

  def free
  end


  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @categories = Category.new
  end

    def create
      @categories = Category.new(category_params)
  
      if @categories.save
        redirect_to [:admin, :categories], notice: "Category created!"
      else
        render :new
      end
    end

    # def destroy
    #   @product = Product.find params[:id]
    #   @product.destroy
    #   redirect_to [:admin, :categories], notice: "Product deleted!"
    # end
  
    def category_params
      params.require(:category).permit(
        :name,
        :id
      )
    end
end
