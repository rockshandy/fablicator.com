require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:bill)
  end
  
  test "should get profile" do
    get :profile, nil, :user_id => @user.id
    assert_response :success, flash.inspect
  end

  test "should get update" do
    get :update, {:id => @user.id}, {:user_id => @user.id}
    assert_redirected_to profile_path
  end
end
