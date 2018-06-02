class Criterion < ApplicationRecord
  C_TYPES = ['quantitative', 'qualitative']
  OPTIM_TYPES = ['max', 'min']
  SCALE_TYPES = ['absolute', 'ordinal', 'name scale']

  has_many :marks

  validates :c_type, inclusion: { in: C_TYPES }, presence: true
  validates :name, presence: true
  validates :optim_type, inclusion: { in: OPTIM_TYPES }, presence: true
  validates :scale_type, inclusion: { in: SCALE_TYPES }, presence: true
end
