ActiveAdmin.register Post do
    permit_params :title, :description, :user_id, :image

    index do
      selectable_column
      id_column
      column :title
      column :description
      column :image_url
      column :user
      column :created_at
      actions
    end

    filter :title
    filter :user
    filter :description
    filter :created_at

    form do |f|
      f.inputs do
        f.input :title
        f.input :description
        f.input :image
        f.input :user, collection: User.all.map { |u| [u.email, u.id] }
      end
      f.actions
    end
  end
