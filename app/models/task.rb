class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, length: { maximum: 1000 }

  enum status: { todo: 1, done: 2 }
end
