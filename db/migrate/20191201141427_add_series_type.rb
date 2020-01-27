class AddSeriesType < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :series_type, :string
  end
end
