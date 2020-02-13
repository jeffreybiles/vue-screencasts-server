class AddCommentsAndNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :deleted
      t.integer :parent_id
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end

    create_table :notifications do |t|
      t.boolean :read
      t.boolean :email_sent
      t.integer :user_id
      t.integer :comment_id
      t.text :content

      t.timestamps
    end
  end
end
