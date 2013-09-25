class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :fio, :string
    add_column :users, :dr, :datetime
    add_column :users, :role_id, :integer 
  end
end
