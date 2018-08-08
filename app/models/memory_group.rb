class MemoryGroup < ApplicationRecord

	belongs_to :user

	has_many :memories

end
