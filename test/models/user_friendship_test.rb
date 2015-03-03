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
		assert users(:kumar).pending_friends.include?(users(:rajesh))
	end

	context "a new instance" do
		setup do
			@user_friendship = UserFriendship.new user: users(:kumar), friend: users(:saswati)
		end

		should "have a pending state" do
			assert_equal 'pending', @user_friendship.state
		end
	end

	context "#send_request_email" do
		setup do
			@user_friendship = UserFriendship.create user: users(:kumar), friend: users(:saswati)
		end

		should "send an email " do
			assert_difference "ActionMailer::Base.deliveries.size", 1 do
				@user_friendship.send_request_email
			end
		end
	end

	context "#accept!" do
		setup do
			@user_friendship = UserFriendship.create user: users(:kumar), friend: users(:saswati)
		end

		should "set the state to accepted" do
			@user_friendship.accept!
			assert_equal 'accepted', @user_friendship.state
		end

		should "send accepted email" do
			assert_difference "ActionMailer::Base.deliveries.size", 1 do
				@user_friendship.accept!
			end
		end

		should "include accepted friend in list of friends" do
			@user_friendship.accept!
			users(:kumar).friends.reload
			assert users(:kumar).friends.include?(users(:saswati))
		end
	end
end
