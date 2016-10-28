class AddUserToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :user_id, :integer
    add_foreign_key :customers, :users, index: true
  end
end
