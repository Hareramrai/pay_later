class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.string :name, index: {unique: true}

      t.timestamps
    end
  end
end
