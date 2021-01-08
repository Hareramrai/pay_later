class User < ApplicationRecord
  has_one :user_account

  has_many :translations

  delegate :credit_limit, :credit_used, to: :user_account 

  def can_afford_transaction_for?(amount)
    credit_limit >= credit_used + amount
  end

  def update_credit_used!(amount)
    user_account.with_lock do
      user_account.credit_used += amount
      user_account.save!
    end
  end
end
