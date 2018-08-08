class Memory < ApplicationRecord

	belongs_to :memory_group

	has_many :problems
	has_many :problem_images
	has_many :answers
	has_many :answer_images

end
