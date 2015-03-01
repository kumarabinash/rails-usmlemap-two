require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:kumar).profile_name
    assert_response :success
    assert_template
  end

  test "should show 404 page when profile not found" do
  	get :show, id: "doesn't exist"
  	assert_response :not_found
  end

  test "that variables are assigned on successful profile viewing" do
  	get :show, id: users(:kumar).profile_name
  	assert assigns(:user)
  	assert_not_empty assigns(:markers)
  end

  test "only show the corretct users markers " do
  	get :show, id: users(:kumar).profile_name
  	assigns(:markers).each do |marker|
  		assert_equal users(:kumar), marker.user
  	end
  end
end
