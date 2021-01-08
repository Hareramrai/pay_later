class CreateMerchantDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :merchant_discounts do |t|
      t.timestamp :valid_from
      t.timestamp :valid_to
      t.float :rate, default: 0.0
      t.references :merchant

      t.timestamps
    end
  end
end
