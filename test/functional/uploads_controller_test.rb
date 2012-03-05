require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include ActionDispatch::TestProcess
  
  test "get index" do
    get :index
    assert_redirected_to :root
    
  end
  
  test "get index as admin" do
    sign_in AdminUser.first
    get :index
    assert_response :success
  end
  
  test "upload new image" do
    post :create
    assert_redirected_to :root
  end
  
  test "upload new image as admin" do
    sign_in AdminUser.first
    post :create, :upload => fixture_file_upload('/files/rails.png', 'image/png')
    assert_redirect_to :index
  end
end
