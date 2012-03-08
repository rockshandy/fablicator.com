class WelcomeController < ApplicationController
  # TODO: look up bot prevention skills see if facebook and twitter and google login is enough
  def index
  end

  # trying out the galleries
  def gallery
    @galleries = Gallery.all
  end

  def about
    #database for diehl to edit for now? each new entry a paragraph
  end

  def faq
    #should this be a db table with 2 columns?
  end

end
