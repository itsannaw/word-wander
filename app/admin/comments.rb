ActiveAdmin.register Comment, :as => "PostComment" do
  permit_params :body, :post_id, :user_id

  index do
    selectable_column
    id_column
    column :body
    column :post
    column :user
    column :created_at
    actions
  end

  filter :body
  filter :post
  filter :user
  filter :created_at

  form do |f|
    f.inputs do
      f.input :body
      f.input :post
      f.input :user, collection: User.all.map { |u| [u.email, u.id] }
    end
    f.actions
  end
end
