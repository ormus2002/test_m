class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string  :mydoc
      t.string  :name
      t.integer :user_id
      t.timestamps
    end
  end
end
