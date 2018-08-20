class MemoryGroup < ApplicationRecord

	belongs_to :user

	has_many :memories
	has_many :memory_stages

end
