class DiaryImage < ApplicationRecord

	belongs_to :diary

	attachment :diary_image

end
