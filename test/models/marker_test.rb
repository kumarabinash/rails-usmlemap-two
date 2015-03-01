require 'test_helper'

class MarkerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "a marker requires content to be entered " do
  	marker = Marker.new
  	assert !marker.save
  	assert !marker.errors[:marker_content].empty?
  end

  test "the marker content is at least 10 letters long " do
  	marker = Marker.new
  	marker.marker_content = 'Hi'
  	assert !marker.save
  	assert !marker.errors[:marker_content].empty?
  end

  test "a marker should have a user id " do
  	marker = Marker.new
  	marker.marker_content = "Hello this should be enough!"
  	assert !marker.save
  	assert !marker.errors[:user_id].empty?
  end

  test "a marker should have an address " do
  	marker = Marker.new
  	marker.marker_content = "Hi there, this is!"
  	marker.user_id = 5
  	assert !marker.save
  	puts marker.errors.inspect
  	assert !marker.errors[:marker_address].empty?
  end

end
