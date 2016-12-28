class AddCountToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :count, :integer
  end
end
