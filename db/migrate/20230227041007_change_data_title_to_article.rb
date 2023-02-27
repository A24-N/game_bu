class ChangeDataTitleToArticle < ActiveRecord::Migration[6.1]
  def change
    change_column :matches, :game_hard, :integer
  end
end
