class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.integer :amount, default: 1
      t.timestamps
    end
  end
end
