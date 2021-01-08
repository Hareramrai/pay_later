module Users
  class CreateUser < ApplicationService
    def initialize(name:, email:, credit_limit:)
      @name = name
      @email = email
      @credit_limit = credit_limit
    end

    def call
      User.transaction do
        user = User.create!(name: @name, email: @email)
        user.create_user_account!(credit_limit: @credit_limit)
        user
      end 
    end
  end
end