class AddSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end

    add_reference :videos, :course, foreign_key: true
  end
end
