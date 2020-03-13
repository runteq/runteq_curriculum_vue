class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 1000 }

  enum status: { todo: 1, doing: 2, done: 3 }
end
