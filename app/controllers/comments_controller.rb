class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.author = current_user if logged_in?
    @post.comments << @comment
    redirect_to post_path(@post)
  end
  
  def edit
    #TODO make so only auther can edit a Comment
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    #TODO make so only auther can edit a Comment
 
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html  { redirect_to(@post,
                      :notice => 'Comment was successfully updated.') }
        format.json  { render :json => {}, :status => :ok }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @comment.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
   
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :ok }
    end
  end
end
