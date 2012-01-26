ActiveAdmin.register Post do
  index do
    column :title
    column :content
    column :created_at
    column :updated_at
    column "Author" do |p|
      p.author ? p.author.email : nil
    end
    default_actions
  end
  
  form :partial => "form"
end
