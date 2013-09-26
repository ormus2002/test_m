class AddVisibleForBuxToUser < ActiveRecord::Migration
  def change
    add_column :users, :visible_for_bux, :boolean, default: false
  end
end
