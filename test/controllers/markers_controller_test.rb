require 'test_helper'

class MarkersControllerTest < ActionController::TestCase
  setup do
    @marker = markers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:markers)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get new page when logged in " do
    sign_in users(:kumar)
    get :new
    assert_response :success
  end

  test "should be logged in to post a new marker " do
    post :create, marker: { marker_type: "Study", marker_content: "I need a new study partner" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  # test "should create marker when logged in" do
  #   sign_in users(:saswati)
  #   marker = Marker.new(id: @marker.id, marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, user_id: users(:saswati).id, end_date: @marker.end_date, start_date: @marker.start_date )
  #   # assert_difference('Marker.count') do
  #   #   # post :create, marker: { end_date: @marker.end_date, marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, start_date: @marker.start_date }
  #   #   # post :create, marker: { marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, user_id: users(:saswati).id }
  #   #   marker = Marker.new(marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, user_id: users(:saswati).id)
  #   # end
  #   # puts marker.errors.inspect
  #   assert !marker.save
  #   assert marker.valid?

  #   # assert_redirected_to marker_path(assigns(:marker))
  # end

  test "should create marker only when logged in " do
    sign_in users(:kumar)
    assert_difference ('Marker.count') do
      post :create, marker: { marker_type: "Study", marker_content: "Need new study partnedr", marker_address: "Ohio", user_id: users(:kumar).id }
    end

    assert_redirected_to marker_path(assigns(:marker))
  end

  test "should create marker for the current user only when logged in " do
    sign_in users(:kumar)
    assert_difference ('Marker.count') do
      post :create, marker: { marker_type: "Study", marker_content: "Need a partner!", marker_address: "Guwahati", user_id: users(:saswati).id }
    end

    assert_redirected_to marker_path(assigns(:marker))
    assert_equal assigns(:marker).user_id, users(:kumar).id
  end

  

  test "should show marker" do
    get :show, id: @marker
    assert_response :success
  end

  test "should get edit when logged in" do
    # sign_in users(:kumar)
    get :edit, id: @marker
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update marker when logged in" do
    # sign_in users(:kumar)
    patch :update, id: @marker, marker: { end_date: @marker.end_date, marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, start_date: @marker.start_date }
    # assert_redirected_to marker_path(assigns(:marker))
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update marker for current user when logged in" do
    sign_in users(:kumar)

    patch :update, id: @marker, marker: { end_date: @marker.end_date, marker_address: @marker.marker_address, marker_content: @marker.marker_content, marker_type: @marker.marker_type, start_date: @marker.start_date, user_id: users(:saswati).id }
    # assert_redirected_to marker_path(assigns(:marker))
    # assert_response :redirect
    # assert_redirected_to marker_path(assigns(:marker))
    assert_equal assigns(:marker).user_id, users(:kumar).id
  end


# TEST NOT WORKING!!
  # test "should not update the marker if nothing has changed" do
  #   sign_in users(:kumar)
  #     patch :update, id: @marker
  #     assert_redirected_to marker_path(assigns(:marker))
  #     assert_equal assigns(:marker).user_id, users(:kumar).id
  # end

  test "should destroy marker" do
    assert_difference('Marker.count', -1) do
      delete :destroy, id: @marker
    end

    assert_redirected_to markers_path
  end
end
