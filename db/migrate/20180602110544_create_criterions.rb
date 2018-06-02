class CreateCriterions < ActiveRecord::Migration[5.1]
  def change
    create_table :criterions do |t|
      t.string :name
      t.string :c_type
      t.string :optim_type
      t.string :measure
      t.string :scale_type
    end
  end
end
