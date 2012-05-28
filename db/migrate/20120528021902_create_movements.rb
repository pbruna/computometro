class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :total
      t.string :subject
      t.date :date
      t.boolean :income

      t.timestamps
    end
  end
end
