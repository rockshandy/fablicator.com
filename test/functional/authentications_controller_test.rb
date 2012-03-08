require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  # TODO: write official test for de-connecting a social connection!
  test "handle create case where display name is already in use" do
    request.env['omniauth.auth'] = {'info'=>{'name'=>'Ted Lee'},'provider'=>'twitter','uid'=>001}
    Authorization.expects('create_from_hash').returns(false).once
    get :create, :provider=>'twitter', :user_id => 999
    assert_redirected_to root_path
    assert flash[:notice].index(/Sorry/)
  end
  
  test "handle create case where display name is not already in use" do
    request.env['omniauth.auth'] = {'info'=>{'name'=>'Ted Unique'},'provider'=>'twitter','uid'=>001}
    get :create, :provider=>'twitter', :user_id => 999
    assert_redirected_to root_path
    assert flash[:notice].index(/Welcome/)
  end
end
