require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "index hides unpublished posts" do
    get :index
    assert_equal 1, assigns(:posts).size
  end
  
  test "trying to show an unpublished post" do
    assert_raise(ActiveRecord::RecordNotFound) {get :show, :id =>2 }
  end
end
