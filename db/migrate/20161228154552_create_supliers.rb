class CreateSupliers < ActiveRecord::Migration
  def change
    create_table :supliers do |t|
      t.string :name
      t.string :phone_number
      t.string :agent_name

      t.timestamps null: false
    end
  end
end
