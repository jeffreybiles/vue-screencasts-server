class CreateVideoTags < ActiveRecord::Migration[6.0]
  def change
    create_table :video_tags do |t|
      t.references :video
      t.references :tag

      t.timestamps
    end
  end
end
