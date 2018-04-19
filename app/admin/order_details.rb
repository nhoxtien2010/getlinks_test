ActiveAdmin.register OrderDetail do
  permit_params :product_id, :order_id, :amount
end
