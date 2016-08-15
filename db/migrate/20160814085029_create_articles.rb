class CreateArticles < ActiveRecord::Migration
  def up
    # drop_table :articles

    create_table :articles do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end

  def down
    drop_table :articles
  end
end
