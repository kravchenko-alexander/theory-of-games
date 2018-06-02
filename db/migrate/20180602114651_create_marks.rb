class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.string :name
      t.references :criterion
    end
  end
end
