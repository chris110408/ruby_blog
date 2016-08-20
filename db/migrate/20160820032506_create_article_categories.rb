class CreateArticleCategories < ActiveRecord::Migration
  def up
    create_table :article_categories do |t|
      t.integer :article_id
      t.integer :category_id
      t.timestamps
    end

  end

  def down
    drop_table :article_categories
  end
end
