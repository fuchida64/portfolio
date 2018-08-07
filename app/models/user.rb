class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attachment :profile_image

  has_many :task_groups
  has_many :diaries
  has_many :followers
  has_many :diary_comments
  has_many :favorites
end
