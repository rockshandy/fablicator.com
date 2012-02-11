# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
Gallery.create([
  {:title=>"The Printer",:picasa_album=>"Printer"},
  {:title=>"The Parts",:picasa_album=>"Printed"}
])

Post.create([
  {:title=>"Woo the first post!",:content=>'<p>The first post of grave importance</p><p>With 2 paragraphs!</p>'},
  {:title=>"Isn't this the most awesome second post of your life?",:content=>"<p><strong>You bet it is</strong>, feel free to use your imagination though as any post I actually write would be too impressive</p>"}
])

