class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :highrise_id
      t.string :name
      t.string :currency
      t.integer :price
      t.string :status

      t.timestamps
    end
    
    add_index :deals, :highrise_id
    add_index :deals, :status
    
  end
end
