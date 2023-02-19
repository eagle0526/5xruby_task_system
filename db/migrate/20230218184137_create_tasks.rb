class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :priority, default: "medium"
      t.string :state, default: "pending"
      t.string :classification
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :deleted_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :deleted_at
  end
end
