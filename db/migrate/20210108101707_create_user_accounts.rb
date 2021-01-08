class CreateUserAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_accounts do |t|
      t.decimal :credit_limit, default: 0
      t.decimal :credit_used,  default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
