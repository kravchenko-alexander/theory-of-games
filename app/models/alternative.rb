class Alternative < ApplicationRecord
  include Comparable

  has_many :vectors, dependent: :destroy

  validates :name, presence: true

  def fetch_vector_by(criterion_id)
    vectors.
      joins(mark: [:criterion]).
      where('criterions.id = ?', criterion_id).
      first
  end

  def <=>(other)
    Criterion.all.map do |criterion|
      fetch_vector_by(criterion.id).mark <=> other.fetch_vector_by(criterion.id).mark
    end.uniq.sum
  end

  def compare_by_electre(other)
    return 0.5 if other.id == id

    criterions_sum = ExpertCriterionMark.all.pluck(:value).sum

    Criterion.all.map do |criterion|
      mark_a = fetch_vector_by(criterion.id).mark
      mark_b = other.fetch_vector_by(criterion.id).mark
      if mark_a > mark_b
        criterion.expert_coefficient
      else
        criterions_sum -= criterion.expert_coefficient if mark_a == mark_b
        0.0
      end
    end.sum / criterions_sum
  end
end
