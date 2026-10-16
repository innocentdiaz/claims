class CreateItemsTable < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :category            # choice_enum is string-backed: stores "professional"
      t.string :description
      t.string :title
      t.boolean :claimed, null: false, default: false
      # t.integer :claimed_by in the future
      t.timestamps
    end
  end
end
