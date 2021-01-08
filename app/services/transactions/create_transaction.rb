class Transactions::CreateTransaction < ApplicationService
  FAILED_MESSAGE = "rejected! (reason: credit limit)"

  def initialize(user_name: , merchant_name: , amount:)
    @user = User.find_by!(name: user_name)
    @merchant = Merchant.find_by!(name: merchant_name)
    @amount = amount.to_f
  end

  def call
    Transaction.transaction do
      return FAILED_MESSAGE unless user.can_afford_transaction_for?(amount)
      current_time = Time.zone.now
      merchant_discount = merchant.active_merchant_discount_for(current_time)
    
      transaction = Transaction
        .create!(
          user: user, 
          merchant: merchant, 
          amount: amount, 
          discount: discount_amount(merchant_discount)
        )
      
      @user.update_credit_used!(amount)

      transaction
    end 
  end

  def discount_amount(merchant_discount)
    amount * merchant_discount.rate / 100.0
  end

  private 

    attr_reader :user, :merchant, :amount
end