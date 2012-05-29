class AddBalanceToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :balance, :integer
  end
end
