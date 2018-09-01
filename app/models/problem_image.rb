class ProblemImage < ApplicationRecord

	belongs_to :memory

	attachment :problem_image

	validates :problem_image, presence: true
	validates :memory_id, presence: true

end
