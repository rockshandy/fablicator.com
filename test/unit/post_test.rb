require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "summary defautly shows first paragraph" do
     assert_equal '<p>the first</p>', posts(:one).summary
  end
  
  test "summary can keep looking for tags if needed" do
    s = posts(:one).summary(%w(</div> </a>))
    assert s.index('</a>'), s
  end
end
