require 'rails_helper'
require 'user'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'Creates a new user if all the fields are provided' do
      @user = User.new()

      @user.first_name = 'Galo'
      @user.last_name = 'Doido'
      @user.email = 'galodoido@atletico.com.br'
      @user.password = 'ClubeAtleticoMineiro'
      @user.password_confirmation = 'ClubeAtleticoMineiro'
      
      @user.save

      expect(@user.errors.count).to eql(0)
    end

    context 'When missing a field' do
      it 'user can not be created without a first name' do
        @user = User.new()

        @user.first_name = nil
        @user.last_name = 'Doido'
        @user.email = 'galodoido@atletico.com.br'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages[0]).to eql("First name can't be blank")
      end

      it 'user can not be created without a last name' do
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = nil
        @user.email = 'galodoido@atletico.com.br'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages[0]).to eql("Last name can't be blank")
      end

      it 'user can not be created without an e-mail' do
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = 'Doido'
        @user.email = nil
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages[0]).to eql("Email can't be blank")
      end
    end

    context 'Information must be correct' do
      it 'password must match' do
        @user = User.new()

        @user.first_name = nil
        @user.last_name = 'Doido'
        @user.email = 'galodoido@atletico.com.br'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'Uma vez ate morrer'
        
        @user.save

        expect(@user.errors.full_messages[0]).to eql("Password confirmation doesn't match Password")
      end

      it 'e-mail must be unique' do
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = 'Doido'
        @user.email = 'galodoido@atletico.com.br'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.count).to eql(0)
        
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = 'Doido'
        @user.email = 'GALODOIDO@ATLETICO.COM.BR'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages[0]).to eql("Email has already been taken")
      end
    end
  end
end
