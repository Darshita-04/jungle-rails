require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      category = Category.create(name: 'Electronics') # Adjust as needed
      product = Product.new(name: 'Laptop', price: 1000, category: category, quantity: 10) # Changed `stock` to `quantity`
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      category = Category.create(name: 'Electronics') # Adjust as needed
      product = Product.new(price: 1000, category: category, quantity: 10) # Changed `stock` to `quantity`
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      category = Category.create(name: 'Electronics') # Adjust as needed
      product = Product.new(name: 'Laptop', category: category, quantity: 10) # Changed `stock` to `quantity`
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a category' do
      product = Product.new(name: 'Laptop', price: 1000, quantity: 10) # Changed `stock` to `quantity`
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

    it 'is not valid without quantity' do
      category = Category.create(name: 'Electronics') # Adjust as needed
      product = Product.new(name: 'Laptop', price: 1000, category: category) # Changed `stock` to `quantity`
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank") # Adjusted error message
    end
  end
end
