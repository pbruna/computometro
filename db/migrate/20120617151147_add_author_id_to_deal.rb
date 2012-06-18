class AddAuthorIdToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :author_id, :integer
  end
end