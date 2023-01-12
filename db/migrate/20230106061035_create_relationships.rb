class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follow, foreign_key: { to_table: :users }
      t.references :follower, foreign_key: { to_table: :users }
      t.timestamps

      t.index [:follow_id, :follower_id], unique: true
    end
  end
end
