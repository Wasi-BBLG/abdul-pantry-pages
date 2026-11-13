class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :meal, null: false
      t.integer :prep_minutes, null: false
      t.string :difficulty, null: false
      t.text :ingredients, null: false
      t.timestamps
    end
    add_index :articles, :meal
  end
end
