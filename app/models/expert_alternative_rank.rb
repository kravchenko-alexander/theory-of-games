class ExpertAlternativeRank < ApplicationRecord
  belongs_to :expert
  belongs_to :alternative

  validates :rank, presence: true, uniqueness: { scope: :expert_id }
  validates :expert_id, uniqueness: { scope: :alternative_id }
end
