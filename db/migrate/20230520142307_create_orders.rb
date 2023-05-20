class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
