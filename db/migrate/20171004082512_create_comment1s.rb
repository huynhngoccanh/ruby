class CreateComment1s < ActiveRecord::Migration[5.1]
  def change
    create_table :comment1s do |t|
      t.string :commenter1
      t.text :body1
      t.timestamps
    end
  end
end
