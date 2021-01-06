class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end

class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => "Jungle", :password => "book" 
end
