class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :width
      t.integer :height
      t.integer :count
      t.float :quantity
      t.date :date
      t.date :deadline
      t.string :state
      t.string :info
      t.float :amount
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
