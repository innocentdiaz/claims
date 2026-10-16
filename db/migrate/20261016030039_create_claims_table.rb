class CreateClaimsTable < ActiveRecord::Migration[8.1]
  def change
    create_table :claims do |t|
      t.references :item, null: false, foreign_key: true
      t.text :story
      t.float :plausible
      t.float :match
      t.float :specificity
      t.timestamps
    end
  end
end
