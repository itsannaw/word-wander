ActiveAdmin.register User do
    permit_params :email, :name, :password

    index do
      selectable_column
      id_column
      column :email
      column :name
      column :created_at
      actions
    end

    filter :email
    filter :name
    filter :created_at

    form do |f|
      f.inputs do
        f.input :email
        f.input :name
        f.input :password
      end
      f.actions
    end
  end
