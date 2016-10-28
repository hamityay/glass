class AddIsactiveToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :is_active, :boolean, default: false
  end
end
