class CreateAlternatives < ActiveRecord::Migration[5.1]
  def change
    create_table :alternatives do |t|
      t.string :name
    end
  end
end
