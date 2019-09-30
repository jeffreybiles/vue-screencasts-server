class AddWatchedVideoRelationshipToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :video_plays do |t|
      t.references :user
      t.references :video

      t.timestamps
    end
  end
end
