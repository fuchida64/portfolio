class Answer < ApplicationRecord

	belongs_to :memory

	validates :answer_content, presence: true
	validates :memory_id, presence: true

end
