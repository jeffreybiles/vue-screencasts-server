class CreateModulesSectionsAndItems < ActiveRecord::Migration[6.0]
  def change
    create_table :training_modules do |t|
      t.string :name
      t.integer :week_number

      t.timestamps
    end

    create_table :training_sections do |t|
      t.string :name
      t.decimal :position
      t.references :training_module

      t.timestamps
    end

    create_table :training_items do |t|
      t.string :title
      t.string :exercise_type
      t.text :text
      t.decimal :position
      t.references :training_section

      t.timestamps
    end

    create_table :training_completions do |t|
      t.references :training_item
      t.references :user

      t.timestamps
    end
  end
end
