class AddIntroToModule < ActiveRecord::Migration[6.0]
  def change
    add_column :training_modules, :intro, :text
  end
end
