require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @post = posts(:one)
    @user = users(:bill)
  end
  
  test "author can edit their comments" do
    get :edit,
      {:post_id=>@post,:id=>comments(:one)},
      {:user_id=>@user.id}
    assert_response :success
  end
  
  test "prevent edit of someone else's comment" do
    get :edit,
      {:post_id=>@post,:id=>comments(:two)},
      {:user_id=>@user.id}
    assert_redirected_to post_path(@post)    
  end
  # FIXME: is somehow going to comments/update rather than redirecting... something with resond? 
  test "author can update their comments after edit" do
    put :update,
      {:post_id=>@post,:id=>comments(:one)},
      {:user_id=>@user.id}
    assert flash[:notice].index(/was successfully/)
    assert_redirected_to post_path(@post)    
  end
  
  test "prevent update of someone else's comment" do
    put :update,
      {:post_id=>@post,:id=>comments(:two)},
      {:user_id=>@user.id}
    assert flash[:warn].index(/Sorry/)
    assert_redirected_to post_path(@post)    
  end
  
  test "author can destroy their comments" do
    delete :destroy,
      {:post_id=>@post,:id=>comments(:one)},
      {:user_id=>@user.id}
    assert flash[:notice].index(/was successfully/)
    assert_redirected_to post_path(@post)    
  end
  
  test "prevent destruction of someone else's comment" do
    delete :destroy,
      {:post_id=>@post,:id=>comments(:two)},
      {:user_id=>@user.id}
    assert flash[:warn].index(/Sorry/)
    assert_redirected_to post_path(@post)    
  end
end
