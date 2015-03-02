require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should belong_to(:user)
  should belong_to(:friend)


  test "that creating a friendship works without raising any errors " do
  	assert_nothing_raised do
	  	UserFriendship.create user: users(:kumar), friend: users(:saswati)
		end
	end

	test "that creating a user friendship on basis of user id and friend is works " do
		UserFriendship.create user_id: users(:kumar).id, friend_id: users(:rajesh).id
		assert users(:kumar).friends.include?(users(:rajesh))
	end
end
