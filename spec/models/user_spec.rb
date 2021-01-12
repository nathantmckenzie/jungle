require 'rails_helper'

RSpec.describe User, type: :model do
    
    describe 'Validations' do
    subject do
      described_class.new(name: 'Johnny Steak',
                          email: 'johnny.steak@hotmail.com'
                          password: 'password'
                          password_confirmation: 'password'
    end

    it 'is valid if it has a name, email, password' do
        expect(subject).to be_valid
    end

    it 'is invalid if it doesnt have a name' do
        subject.name = nil
        expect(subject).to be_invalid
    end

    it 'is invalid if it doesnt have an email' do
        subject.email = nil
        expect(subject).to be_invalid
    end

    it 'is invalid if it doesnt have a password' do
        subject.password = nil
        expect(subject).to be_invalid
    end

    it 'is invalid if the password and confirmation password do not match' do
        subject.password_confirmation = 'notpassword'
        expect(subject).to be_invalid
    end

    it 'is invalid if email already exists' do
        subject.save
        
        duplicate_user User.new(
          name: 'Johnny Steak',
          email: 'johnny.steak@hotmail.com'
          password: 'password'
          password_confirmation: 'password'
        )
        expect(duplicate_user).to be_invalid
    end

    it 'is invalid if password length is less than 10 characters' do
        subject.password = 'hi'
        subject.password_confirmation = 'hi'
        expect(subject).to be_invalid
    end

    describe '.authenticate_with_credentials' do
        it 'returns the user if the user is authenticated' do
          subject.save
          user = User.authenticate_with_credentials('johnny.steak@hotmail.com', 'password')
          expect(user).to be_instance_of(User)
        end

        it 'saves if the email is in all caps' do
           subject.save
           user = User.authenticate_with_credentials('JOHNNY.STEAK@HOTMAIL.COM', 'password')
           expect(user).to be_instance_of(User)
        end

        it 'saves if the password is in all caps' do
            subject.save
            user = User.authenticate_with_credentials('johnny.steak@hotmail.com', 'PASSWORD')
            expect(user).to be_instance_of(User)
        end
    end


end