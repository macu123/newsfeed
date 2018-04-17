class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :created_by
      t.integer :comments_count
      t.integer :score
      t.string :title
      t.string :url

      t.timestamps null: false
    end
  end
end
