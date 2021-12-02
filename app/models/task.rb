class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 1000 }
end
