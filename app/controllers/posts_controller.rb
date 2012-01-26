class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.includes({:comments=>:author}).find(params[:id])
    
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @post }
    end
  end
end
