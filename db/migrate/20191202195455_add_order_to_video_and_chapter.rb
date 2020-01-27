class AddOrderToVideoAndChapter < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :order, :decimal
    add_column :courses, :order, :decimal
  end
end
