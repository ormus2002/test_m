class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fio, :string
    add_column :users, :dr, :datetime
  end
end
