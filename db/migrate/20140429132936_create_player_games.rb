class CreatePlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |t|
      t.string :code
      t.string :league
      t.string :team
      t.integer :year
      t.boolean :starter
      t.integer :starter_position

      t.timestamps
    end
  end
end
