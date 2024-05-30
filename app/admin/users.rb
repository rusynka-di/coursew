# app/admin/user.rb
ActiveAdmin.register User do
  permit_params :name, :nickname, :email, :password, :password_confirmation, :role, :admin

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :nickname
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role, as: :select, collection: User.roles.keys, include_blank: false
    end
    f.actions
  end
end
