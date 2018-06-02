class ExpertCriterionMark < ApplicationRecord
  belongs_to :expert
  belongs_to :criterion

  validates :value, presence: true
  validates :expert_id, uniqueness: { scope: :criterion_id }
end
