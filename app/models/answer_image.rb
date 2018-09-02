class AnswerImage < ApplicationRecord

	belongs_to :memory

	attachment :answer_image

	# validates :answer_image, presence: true
	# validates :memory_id, presence: true

end
