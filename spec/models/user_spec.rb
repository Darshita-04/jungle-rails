require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'requires a password and password_confirmation' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'requires password and password_confirmation to match' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: 'password', password_confirmation: 'different')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'requires a unique email (case insensitive)' do
      User.create!(first_name: 'Jane', last_name: 'Doe', email: 'TEST@EXAMPLE.COM', password: 'password', password_confirmation: 'password')
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires an email, first name, and last name' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'requires a password of at least 6 characters' do
      user = User.new(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: '123', password_confirmation: '123')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    describe '.authenticate_with_credentials' do
      before do
        @user = User.create!(first_name: 'John', last_name: 'Doe', email: 'test@example.com', password: 'password', password_confirmation: 'password')
      end
  
      it 'authenticates with valid credentials' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
        expect(authenticated_user).to eq(@user)
      end
  
      it 'returns nil for incorrect password' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
        expect(authenticated_user).to be_nil
      end
  
      it 'authenticates with extra spaces around email' do
        authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
        expect(authenticated_user).to eq(@user)
      end
  
      it 'authenticates with wrong case email' do
        authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')
        expect(authenticated_user).to eq(@user)
      end
    end
  end
  
  end
