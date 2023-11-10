require 'rails_helper'
require 'product'
require 'category'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'Test Category')      
    end

    it 'Creates a new Product if all fields are provided' do
      @product = Product.new()

      @product.name = 'My product'
      @product.description = 'This is a test product'
      @product.image = 'https://atletico.com.br/wp-content/uploads/2022/01/atletico.svg'
      @product.price_cents = 1300
      @product.quantity = 13
      @product.category_id = @category.id

      @product.save

      #pp @product.errors.full_messages

      expect(@product.errors.count).to eql(0)
    end

    context 'When missing a field' do
      it 'product can not be created without a name' do
        @product = Product.new()

        @product.name = nil
        @product.description = 'This is a test product'
        @product.image = 'https://atletico.com.br/wp-content/uploads/2022/01/atletico.svg'
        @product.price_cents = 1300
        @product.quantity = 13
        @product.category_id = @category.id

        @product.save

        expect(@product.errors.full_messages[0]).to eql("Name can't be blank")
      end

      it 'product can not be created without a price' do
        @product = Product.new()

        @product.name = 'My product'
        @product.description = 'This is a test product'
        @product.image = 'https://atletico.com.br/wp-content/uploads/2022/01/atletico.svg'
        @product.price_cents = nil
        @product.quantity = 13
        @product.category_id = @category.id

        @product.save

        expect(@product.errors.full_messages[0]).to eql("Price cents is not a number")
      end

      it 'product can not be created without a defined quantity' do
        @product = Product.new()

        @product.name = 'My product'
        @product.description = 'This is a test product'
        @product.image = 'https://atletico.com.br/wp-content/uploads/2022/01/atletico.svg'
        @product.price_cents = 1300
        @product.quantity = nil
        @product.category_id = @category.id

        @product.save

        expect(@product.errors.full_messages[0]).to eql("Quantity can't be blank")
      end

      it 'product can not be created without a category' do
        @product = Product.new()

        @product.name = 'My product'
        @product.description = 'This is a test product'
        @product.image = 'https://atletico.com.br/wp-content/uploads/2022/01/atletico.svg'
        @product.price_cents = 1300
        @product.quantity = 13
        @product.category_id = nil

        @product.save

        expect(@product.errors.full_messages[0]).to eql("Category must exist")
      end
    end
  end
end
