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


	before_create do
		problem.mark_for_destruction if problem.problem_content.blank?
		problem_image.mark_for_destruction if problem_image.problem_image.blank?
		answer.mark_for_destruction if answer.answer_content.blank?
		answer_image.mark_for_destruction if answer_image.answer_image.blank?
	end

end
