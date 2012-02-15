class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.author = current_user if logged_in?
    @post.comments << @comment
    redirect_to post_path(@post)
  end
  
  # TODO: debate making comments editable only for a certain time
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.includes(:author).find(params[:id])
    
    return unless author?
  end
  
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if author?(false)
        if @comment.update_attributes(params[:comment])
          format.html  { redirect_to( @post,
                        :notice => 'Comment was successfully updated.') }
          format.json  { render :json => {}, :status => :ok }
        else
          format.html  { render :action => "edit" }
          format.json  { render :json => @comment.errors,
                        :status => :unprocessable_entity }
        end
      else  
        format.html { redirect_to @post }
        format.json { render :json => "Sorry, you aren't the author of that" }
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
   
    respond_to do |format|
      if author?(false)
        format.html { redirect_to @post,
                        :notice => 'Comment was successfully destroyed' }
        format.json { head :ok }
      else
        format.html { redirect_to @post }
        format.json { render :json => "Sorry, you aren't the author of that" }
      end
    end
  end
  
  protected
  
  def author?(redirect=true)
    unless @comment.author == current_user
      flash[:warn] = "Sorry, that comment isn't your's to edit"
      redirect_to post_path(@post) if redirect
      return false
    end
    return true
  end
end
