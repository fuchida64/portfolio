class DefaultStage < ApplicationRecord

	belongs_to :user

	validates :period, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

end
