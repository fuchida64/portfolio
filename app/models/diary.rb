class Diary < ApplicationRecord

	belongs_to :user

	has_many :diary_images, dependent: :destroy
	accepts_nested_attributes_for :diary_images, allow_destroy: true

	has_many :diary_comments
	has_many :favorites

	validates :title, presence: true
	validates :content, presence: true
	validates :diary_date, presence: true
	validates :inform_status, presence: true

	before_create do
		diary_images.each{ |diary_image| diary_image.mark_for_destruction if diary_image.diary_image.blank? }
	end

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(search)
		if search
			Diary.where(['(title LIKE ?) OR (content LIKE ?)', "%#{search}%", "%#{search}%"]).where(inform_status: '公開')
		else
			Diary.all
		end
	end

end
