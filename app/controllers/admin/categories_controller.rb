class Admin::CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @categories = Category.all.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Category created successfully!"
    else
      render :new, alert: "Failed to create category."
    end
  end

  private

  
  def category_params
    params.require(:category).permit(:name)
  end

  def authenticate
    authenticate_or_request_with_http_basic("Administration") do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end
end

