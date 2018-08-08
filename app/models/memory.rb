class Memory < ApplicationRecord

	belongs_to :memory_group

	has_one :problem
	has_one :problem_image
	has_one :answer
	has_one :answer_image

	accepts_nested_attributes_for :problem, allow_destroy: true
	accepts_nested_attributes_for :problem_image, allow_destroy: true
	accepts_nested_attributes_for :answer, allow_destroy: true
	accepts_nested_attributes_for :answer_image, allow_destroy: true

end
