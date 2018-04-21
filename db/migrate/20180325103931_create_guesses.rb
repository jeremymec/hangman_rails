class CreateGuesses < ActiveRecord::Migration[5.1]
  def change
    create_table :guesses do |t|
      t.references :game, foreign_key: true
      t.string :letter

      t.timestamps
    end
  end
end
