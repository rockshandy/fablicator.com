require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  test "failed to create unique user" do
    u = User.create_from_hash!({'info'=>{'name'=>'Ted Lonely'}},123)
    assert !Authorization.create_from_hash({'info'=>{'name'=>'Ted Loy'}}, nil, 123)
  end
end
