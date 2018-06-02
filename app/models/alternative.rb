class Alternative < ApplicationRecord
  has_many :vectors, dependent: :destroy

  validates :name, presence: true
end
