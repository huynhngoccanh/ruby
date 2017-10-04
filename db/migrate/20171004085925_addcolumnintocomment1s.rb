class Addcolumnintocomment1s < ActiveRecord::Migration[5.1]
  def change
  	add_column :comment1s, :part_number, :string
    add_index :comment1s, :part_number
  end
end
