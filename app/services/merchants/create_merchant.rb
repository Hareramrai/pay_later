class Merchants::CreateMerchant < ApplicationService
  def initialize(name: , discount:)
    @name = name
    @discount = discount
  end

  def call
    Merchant.transaction do
      merchant = Merchant.create!(name: @name)
      merchant.merchant_discounts.create!(rate: @discount, valid_from: Time.zone.now)
      merchant
    end 
  end
end