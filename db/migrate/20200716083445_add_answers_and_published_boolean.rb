class AddAnswersAndPublishedBoolean < ActiveRecord::Migration[6.0]
  def change
    add_column :training_items, :published, :boolean, default: true
    add_column :training_items, :answer, :text
  end
end
