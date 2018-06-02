class Criterion < ApplicationRecord
  C_TYPES = ['quantitative', 'qualitative']
  OPTIM_TYPES = ['max', 'min']
  SCALE_TYPES = ['absolute', 'ordinal', 'name scale']

  has_many :marks
  has_many :expert_criterion_marks, dependent: :destroy

  validates :c_type, inclusion: { in: C_TYPES }, presence: true
  validates :name, presence: true
  validates :optim_type, inclusion: { in: OPTIM_TYPES }, presence: true
  validates :scale_type, inclusion: { in: SCALE_TYPES }, presence: true

  def normalize_marks
    if c_type == 'qualitative'
      marks.each { |mark| mark.update!(norm_mark: 1.0) }
    else
      max = marks.pluck(:name).map(&:to_f).max
      min = marks.pluck(:name).map(&:to_f).min

      if optim_type == 'max'
        marks.each do |mark|
          mark.update!(norm_mark: (mark.name.to_f - min) / (max - min))
        end
      else
        marks.each do |mark|
          mark.update!(norm_mark: (max - mark.name.to_f) / (max - min))
        end
      end
    end
  end

  def expert_coefficient
    expert_criterion_marks.pluck(:value).sum
  end
end
