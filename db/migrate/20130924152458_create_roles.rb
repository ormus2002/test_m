class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :builtin, :default => 0, :null => false
      t.string :name
      t.timestamps
    end
  end
end
