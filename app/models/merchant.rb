class Merchant < ApplicationRecord
  has_many :merchant_discounts
  has_many :transactions

  def active_merchant_discount_for(current_time)
    merchant_discounts
      .where(
        "valid_from <= :current_time AND (valid_to IS NULL OR valid_to >= :current_time)", 
        current_time: current_time
      ).first
  end
end
