class Vector < ApplicationRecord
  belongs_to :mark
  belongs_to :alternative

  validates :alternative_id, uniqueness: { scope: :mark_id }
end
