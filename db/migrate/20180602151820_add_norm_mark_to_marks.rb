class AddNormMarkToMarks < ActiveRecord::Migration[5.1]
  def change
    add_column :marks, :norm_mark, :float, default: 1.0
  end
end
