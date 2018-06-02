class Mark < ApplicationRecord
  belongs_to :criterion
  has_many :vectors, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :criterion_id }
end
