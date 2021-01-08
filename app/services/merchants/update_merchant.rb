class Merchants::UpdateMerchant < ApplicationService
  def initialize(name: , discount: )
    @name = name
    @discount = discount
  end

  def call
    Merchant.transaction do
      merchant = Merchant.find_by!(name: @name)
      merchant.merchant_discounts.where(valid_to: nil).update_all(valid_to: Time.zone.now - 1.seconds)
      merchant.merchant_discounts.create!(rate: @discount, valid_from: Time.zone.now)
      merchant
    end 
  end
end