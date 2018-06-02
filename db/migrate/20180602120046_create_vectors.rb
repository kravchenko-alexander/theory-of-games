class CreateVectors < ActiveRecord::Migration[5.1]
  def change
    create_table :vectors do |t|
      t.references :alternative
      t.references :mark
    end
  end
end
