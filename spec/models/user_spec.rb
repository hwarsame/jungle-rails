require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'saves with all fields filled in' do
      user = User.new(
        name: 'Test User', 
        email: 'user@example.com', 
        password: 'test123', 
        password_confirmation: 'test123')
      expect(user).to be_valid
    end

    it 'invalid without name' do
      user = User.create(
        name: nil, 
        email: 'user@example.com', 
        password: 'test123', 
        password_confirmation: 'test123')
      expect(user.errors[:name]).to include("can't be blank")
    end 

    it 'is invalid without password' do
      user = User.create(
        name: 'Test User', 
        email: 'user@example.com', 
        password: nil, 
        password_confirmation: 'test123')
      expect(user).to_not be_valid
      expect(user.errors.messages[:password]).to include("can't be blank")
    end

    it 'is invalid without password confirmation' do
      user = User.create(
        name: 'Test User', 
        email: 'user@example.com', 
        password: 'test123', 
        password_confirmation: nil)
      expect(user).to_not be_valid
      expect(user.errors.messages[:password_confirmation]).to include("can't be blank")
    end

    it 'is invalid without password and password confirmation doesnt match' do
      user = User.create(
        name: 'Test User', 
        email: 'user@example.com', 
        password: 'test123', 
        password_confirmation: 'iamnotatesthaha')
      expect(user).to_not be_valid
      expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it 'is invalid without a email' do
      user = User.new(
        name: 'Test User', 
        email: nil, 
        password: 'test123', 
        password_confirmation: 'test123')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid case sensitive email' do
      user = User.create(
        name: 'Test User', 
        email: 'test@test.COM', 
        password: 'test123', 
        password_confirmation: 'test123')
      user1 = User.create(
        name: 'Existing Dude', 
        email: 'TEST@TEST.com', 
        password: 'test123', 
        password_confirmation: 'test123')
        expect(user1.errors[:email].first).to eq('has already been taken')
    end

    it 'password length less then 3' do
        user = User.create(
          name: 'Test User', 
          email: 'user@example.com', 
          password: '12', 
          password_confirmation: '12')
        expect(user).to_not be_valid
        expect(user.errors.messages[:password]).to include("is too short (minimum is 3 characters)")
      end


  end
  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.create(
          name: 'Test User', 
          email: 'test@test.com', 
          password: 'test123', 
          password_confirmation: 'test123'
        )
        user = User.authenticate_with_credentials('test@test.com', 'test123')
        expect(user).not_to be(nil)
    end

      it 'should pass check if email is in db and password matches email ' do
        user = User.create(
                name: 'Test User', 
                email: 'user@example.com', 
                password: 'test123', 
                password_confirmation: 'test123'
              )
          check = User.authenticate_with_credentials('user@example.com', 'test123')
      expect(check).to be ==(user)
      end
  end

end