class AnswerImage < ApplicationRecord

	belongs_to :memory

	attachment :answer_image

end
