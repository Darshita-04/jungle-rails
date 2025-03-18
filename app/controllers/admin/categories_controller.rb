class Admin::CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @categories = Category.all
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic("Administration") do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end
end
