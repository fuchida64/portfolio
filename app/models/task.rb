class Task < ApplicationRecord

	belongs_to :task_group

	has_one :task_detail
	accepts_nested_attributes_for :task_detail, allow_destroy: true

	validates :title, presence: true, length: { in: 1..20 }

end
