class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :link
      t.text :description
      t.timestamps null: false
    end
  end
end
