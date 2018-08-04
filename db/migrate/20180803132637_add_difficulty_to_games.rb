class AddDifficultyToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :difficulty, :string
  end
end
