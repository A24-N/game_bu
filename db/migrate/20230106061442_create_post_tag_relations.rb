class CreatePostTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tag_relations do |t|
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
