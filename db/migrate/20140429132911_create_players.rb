class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :code
      t.string :name
      t.string :bats
      t.string :throws

      t.timestamps
    end
  end
end
