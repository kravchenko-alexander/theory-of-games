class CreateExpertAlternativeRank < ActiveRecord::Migration[5.1]
  def change
    create_table :expert_alternative_ranks do |t|
      t.references :expert
      t.references :alternative
      t.integer :rank
    end
  end
end
