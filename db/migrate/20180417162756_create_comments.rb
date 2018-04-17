class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :created_by
      t.text :text
      t.references :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
