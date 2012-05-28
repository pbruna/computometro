class AddChecksumToMovements < ActiveRecord::Migration
  def change
    add_column :movements, :checksum, :string
    add_index :movements, :checksum
  end
end