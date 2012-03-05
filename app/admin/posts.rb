ActiveAdmin.register Post do
  show do |p|
    attributes_table do
      row :title
      row :content do
        post.content.html_safe
      end
      row :publish
      row :created_at
      row :updated_at
    end
    div do
      render "comments", :locals => {:post => p}
    end
  end
  
  index do
    column :title
    column :content
    column :created_at
    column :updated_at
    column :publish
    column "Author" do |p|
      p.author ? p.author.email : nil
    end
    default_actions
  end
  
  form :partial => "form"
end
