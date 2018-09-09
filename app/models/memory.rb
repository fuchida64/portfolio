class Memory < ApplicationRecord

	belongs_to :memory_group

	attachment :problem_image
	attachment :answer_image

	validates :image_or_conetnt, presence: true

	# before_create do
	# 	problem.mark_for_destruction if problem.problem_content.blank?
	# 	problem_image.mark_for_destruction if problem_image.problem_image.blank?
	# 	answer.mark_for_destruction if answer.answer_content.blank?
	# 	answer_image.mark_for_destruction if answer_image.answer_image.blank?
	# end

	private

    def image_or_conetnt
		problem_image.presence or problem_content.presence
    end

end
