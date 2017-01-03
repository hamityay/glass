class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :dimensions
      t.references :product, index: true, foreign_key: true
      t.references :suplier, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
