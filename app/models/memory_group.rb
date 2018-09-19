class MemoryGroup < ApplicationRecord

	belongs_to :user

	has_many :memories, dependent: :destroy
	has_many :memory_stages, dependent: :destroy

	validates :title, presence: true, length: { in: 1..20 }
	validates :period, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

end
