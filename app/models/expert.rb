class Expert < ApplicationRecord
  has_many :expert_criterion_marks, dependent: :destroy
  has_many :expert_alternative_ranks, dependent: :destroy

  validates :name, presence: true
end
