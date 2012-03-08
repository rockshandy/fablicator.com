require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can try to support unique display name" do
    u = User.create_from_hash!({'info'=>{'name'=>"Ted Loney"}}, 123)
    assert u.errors.size, 0
    assert_equal "Ted L.123", u.display_name
  end
  
  test "creat user fine if unique" do
    u = User.create_from_hash!({'info'=>{'name'=>"Ted Unique"}})
    assert u.errors.size, 0
    assert_equal "Ted U.", u.display_name
  end
end
