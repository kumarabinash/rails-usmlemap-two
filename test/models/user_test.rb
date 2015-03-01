require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user should enter first name " do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "user should enter last name " do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "user should enter profile name " do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "user's profile name should be unique" do
  	user = User.new
  	user.profile_name = users(:kumar).profile_name
  	assert !user.save
  	# puts user.errors.inspect
  	assert !user.errors[:profile_name].empty?
  end

  test "user's profile name shouldn't contain spaces " do
  	user = User.new
  	user.profile_name = "Kumar Abinash"
  	assert !user.save
  	# puts user.errors.inspect
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "giving a nice username doesn't throw any errors" do
      user = User.new(first_name: 'Rajesh', last_name: 'Patra', email: 'p7.rajesh@gmail.com', profile_name: 'rajesh')
    user.password= 'password'
    puts user.errors.inspect
    assert user.valid?
  end
end
