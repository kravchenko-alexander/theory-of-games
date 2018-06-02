class Mark < ApplicationRecord
  include Comparable

  belongs_to :criterion
  has_many :vectors, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :criterion_id }

  def <=>(other)
    raise StandardError if criterion_id != other.criterion_id

    if criterion.c_type == 'qualitative'
      0
    else
      if name == other.name
        0
      else
        if criterion.optim_type == 'max'
          if name.to_i > other.name.to_i
            1
          else
            -1
          end
        else
          if name.to_i < other.name.to_i
            1
          else
            -1
          end
        end
      end
    end
  end
end
