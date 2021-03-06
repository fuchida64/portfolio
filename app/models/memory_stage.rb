class MemoryStage < ApplicationRecord

	belongs_to :memory_group

	validates :period, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

end
