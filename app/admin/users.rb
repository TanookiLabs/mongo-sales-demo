ActiveAdmin.register User do
  permit_params :email, :role, :first_name, :last_name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :first_name
    column :last_name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email, as: :string
  filter :role
  filter :first_name
  filter :last_name
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email, as: :string
      f.input :role, include_blank: false
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
