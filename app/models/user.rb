class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :markers
  has_many :user_friendships
  has_many :friends, through: :user_friendships

  validates :first_name, :last_name, :profile_name, presence: true

  validates :profile_name, uniqueness: true,
  							format: {
                  with: /^[a-zA-Z0-9_-]+$/,
  								message: "Must be formatted correctly.",
                  multiline: true
  							}

  def to_param
    profile_name
  end
end