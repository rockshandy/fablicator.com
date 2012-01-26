ActiveAdmin.register Gallery do
  index do
    column :title
    column :picasa_album
    default_actions
  end
end
