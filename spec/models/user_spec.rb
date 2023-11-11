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

        expect(@user.errors.full_messages.first).to eql("First name can't be blank")
      end

      it 'user can not be created without a last name' do
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = nil
        @user.email = 'galodoido@atletico.com.br'
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages.first).to eql("Last name can't be blank")
      end

      it 'user can not be created without an e-mail' do
        @user = User.new()

        @user.first_name = 'Galo'
        @user.last_name = 'Doido'
        @user.email = nil
        @user.password = 'ClubeAtleticoMineiro'
        @user.password_confirmation = 'ClubeAtleticoMineiro'
        
        @user.save

        expect(@user.errors.full_messages.first).to eql("Email can't be blank")
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

        expect(@user.errors.full_messages.first).to eql("Password confirmation doesn't match Password")
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

        expect(@user.errors.full_messages.first).to eql("Email has already been taken")
      end
    end

    it 'password can not have less than 3 characters' do
      @user = User.new()

      @user.first_name = 'Galo'
      @user.last_name = 'Doido'
      @user.email = 'galodoido@atletico.com.br'
      @user.password = '13'
      @user.password_confirmation = '13'
      
      @user.save

      expect(@user.errors.full_messages.first).to eql("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      user = User.new()

      user.first_name = 'Galo'
      user.last_name = 'Doido'
      user.email = 'galodoido@atletico.com.br'
      user.password = 'ClubeAtleticoMineiro'
      user.password_confirmation = 'ClubeAtleticoMineiro'
      
      user.save
    end

    it "email must belong to a user" do
      user = User.authenticate_with_credentials('galo13@atletico.com.br', 'ClubeAtleticoMineiro')

      expect(user).to eql(nil)
    end

    it "password must be correct" do
      user = User.authenticate_with_credentials('galodoido@atletico.com.br', 'Galo')

      expect(user).to eql(nil)
    end

    it "user should log in when credentials are correct" do
      user = User.authenticate_with_credentials('galodoido@atletico.com.br', 'ClubeAtleticoMineiro')

      expect(user).to be_a User
    end    

    it "user should log in when having leading or trailing spaces" do
      user = User.authenticate_with_credentials(' galodoido@atletico.com.br ', 'ClubeAtleticoMineiro')

      expect(user).to be_a User
    end

    it "user should log in when informing the e-mail in a different case" do
      user = User.authenticate_with_credentials('GALODOIDO@ATLETICO.COM.BR', 'ClubeAtleticoMineiro')

      expect(user).to be_a User
    end
  end
end
