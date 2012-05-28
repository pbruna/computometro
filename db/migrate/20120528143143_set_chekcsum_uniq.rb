class SetChekcsumUniq < ActiveRecord::Migration
  def up
    change_column :movements, :checksum, :string, :uniq => true
  end

  def down
    change_column :movements, :checksum, :string, :uniq => false
  end
end