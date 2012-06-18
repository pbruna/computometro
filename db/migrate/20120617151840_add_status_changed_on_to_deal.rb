class AddStatusChangedOnToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :status_changed_on, :date
  end
end
