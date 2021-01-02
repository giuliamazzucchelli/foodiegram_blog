class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, null:false
      t.integer :servings
      t.integer :prep_time, null:false
      t.integer :cook_time
      t.text :ingredients, null:false
      t.text :directions, null:false
      t.text :notes
      t.datetime :created_at
      t.datetime :updated_at
      t.references :user, null: false, foreign_key: true
    end
  end
end
