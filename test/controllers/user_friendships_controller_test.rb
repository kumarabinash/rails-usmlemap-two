require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  context "#index" do
    context "when not logged in" do
      should "redirect to the login page" do
        get :index
        assert_response :redirect
      end
    end

    context "when logged in " do
      setup do
        @friendship1 = create(:pending_user_friendship, user: users(:kumar), friend: create(:user, first_name: 'Pending', last_name: 'Friend'))
        @friendship2 = create(:accepted_user_friendship, user: users(:kumar), friend: create(:user, first_name: 'Active', last_name: 'Friend'))

        sign_in users(:kumar)
        get :index
      end


      should "get the index page without errors" do
        assert_response :success
      end

      should "assign user friendship to instance variables" do
        assert assigns(:user_friendships)
      end

      should "show friends names once we get the page" do
        assert_match /Pending/, response.body
        assert_match /Active/, response.body
      end
    end
  end

  context "/new" do
  	context "when not logged in" do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  		end
  	end

  	context "when logged in" do
  		setup do
  			sign_in users(:kumar)
  		end

  		should "get the new page and return success " do
  			get :new
  			assert_response :success
  		end

  		should "set a flash error if the friend_id param is missing" do
  			get :new, {}
  			assert_equal "Friend Required", flash[:error]
  		end

  		should "display the friend's name" do
  			get :new, friend_id: users(:saswati)
  			assert_match /#{users(:saswati).first_name}/, response.body
  		end

  		should "assign new user friendship " do
  			get :new, friend_id: users(:saswati)
  			assert assigns(:user_friendship)
  		end

  		should "assign new user friendship to the correct friend" do
  			get :new, friend_id: users(:saswati)
  			assert_equal users(:saswati), assigns(:user_friendship).friend
  		end

  		should "assign new user friendship to the currently logged in user" do
  			get :new, friend_id: users(:saswati)
  			assert_equal users(:kumar), assigns(:user_friendship).user
  		end

  		should "get a 404 page when the friend is not found"	do
  			get :new, friend_id: 'invalid'
  			assert_response :not_found
  		end

  		should "ask if you really wanna make friendship" do
  			get :new, friend_id: users(:saswati)
  			assert_match /Do you really want to be friends with #{users(:saswati).first_name}?/, response.body
  		end
  	end
  end

  context "#create" do
  	context "when not logged in" do
  		should "redirect to login page " do
  			get :new
  			assert_response :redirect
  			assert_redirected_to new_user_session_path
  		end
  	end

  	context "when logged in " do
  		setup do
  			sign_in users(:kumar)
  		end

  		context "with no friend_id" do
  			setup do
  				post :create
  			end

  			should "set the flash error message" do
  				assert !flash[:error].empty?
  			end 

  			should "redirect to site's root path" do
  				assert_redirected_to root_path
  			end
	  	end

	  	context "with a valid friend id" do
	  		setup do
	  			post :create, user_friendship: {friend_id: users(:saswati) }
	  		end

	  		should "assign a friend object" do
	  			assert assigns(:friend)
	  			assert_equal users(:saswati), assigns(:friend)
	  		end

	  		should "assign a user_friendship object" do
	  			assert assigns(:user_friendship)
	  			assert_equal users(:kumar), assigns(:user_friendship).user
	  			assert_equal users(:saswati), assigns(:user_friendship).friend
	  		end

	  		should "create a friendship" do
	  			assert users(:kumar).pending_friends.include?(users(:saswati))
	  		end


	  		should "set the flash success message" do
	  			assert flash[:success]
	  			assert_equal "You are now friends with #{users(:saswati).first_name}", flash[:success]
	  		end
	  	end


  	end
  end

  context "#accept" do
    context "when not logged in" do
      should "redirect to login page" do
        put :accept, id: 1
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
    context "when logged in" do
      setup do
        @user_friendship = create(:pending_user_friendship, user: users(:kumar))
        sign_in users(:kumar)
        put :accept, id: @user_friendship
        @user_friendship.reload
      end

      should "assign a user_friendship" do
        assert assigns(:user_friendship)
        assert_equal @user_friendship, assigns(:user_friendship)
      end

      should "update the state to accepted" do
        assert_equal 'accepted', @user_friendship.state
      end
    end
  end

  context "#edit" do
    context "when not logged in" do
      should "redirect to login page" do
        get :edit, id: 1
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end

    context "when logged in" do
      setup do
        @user_friendship = create(:pending_user_friendship, user: users(:kumar))
        sign_in users(:kumar)
        get :edit, id: @user_friendship
      end

      should "get the edit page and return success" do
        assert_response :success
      end

      should "assign to user_friendship " do
        assert assigns(:user_friendship)
      end

      should "assign to frined" do
        assert assigns(:friend)
      end
    end
  end



end
