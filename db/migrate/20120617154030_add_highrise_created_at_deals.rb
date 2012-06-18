class AddHighriseCreatedAtDeals < ActiveRecord::Migration
  def change
    add_column :deals, :highrise_created_at, :datetime
  end
end
