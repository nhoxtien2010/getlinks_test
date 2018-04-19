ActiveAdmin.register Product do
  menu if: proc{ current_user.admin? }
  permit_params :name, :price
  index do
    selectable_column
    id_column
    column :name
    column :price
    actions
  end
end
