class Problem < ApplicationRecord

	belongs_to :memory

	validates :problem_content, presence: true
	validates :memory_id, presence: true

end
