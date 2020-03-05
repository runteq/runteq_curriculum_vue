class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, length: { maximum: 1000 }
end
