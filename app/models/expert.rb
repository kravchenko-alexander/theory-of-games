class Expert < ApplicationRecord
  has_many :expert_criterion_marks, dependent: :destroy

  validates :name, presence: true
end
