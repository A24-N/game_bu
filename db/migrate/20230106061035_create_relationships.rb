class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follow, foreign_key: true
      t.references :follower, foreign_key: true
      t.timestamps
    end
  end
end
