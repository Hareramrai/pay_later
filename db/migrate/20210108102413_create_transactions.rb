class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.decimal :discount, default: 0

      t.timestamps
    end
  end
end
