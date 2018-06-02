class CreateExpertCriterionMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :expert_criterion_marks do |t|
      t.references :expert
      t.references :criterion
      t.float :value
    end
  end
end
