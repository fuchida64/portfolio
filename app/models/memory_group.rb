class MemoryGroup < ApplicationRecord

	belongs_to :user

	has_many :memories
	has_many :memory_stages

	validates :title, presence: true, length: { in: 1..20 }

end
