ActiveAdmin.register Product do
  permit_params :name, :price
  index do
    selectable_column
    id_column
    column :name
    column :price
    actions
  end
end
