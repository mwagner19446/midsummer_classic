# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

## Iterate through each file
## 1) Upsert Player Table (from the Roster Files)
## 2) Insert PlayerGame (from the Roster Files)
## 3) Update PlayerGame (from the Game Event Files)

Player.destroy_all
PlayerGame.destroy_all

# Step 1 & Step 2:
Dir["db/seed_data/*.ROS"].each do |file_name|
  file = File.new(file_name, "r")

  file.each do |line|
    player = line.split(",")
    player_code = player[0].present? ? player[0].chomp.gsub(/"/,""): ""
    player_lastName = player[1].present? ? player[1].chomp.gsub(/"/,""): ""
    player_firstName = player[2].present? ? player[2].chomp.gsub(/"/,""): ""
    player_bats = player[3].present? ? player[3].chomp.gsub(/"/,""): ""
    player_throws = player[4].present? ? player[4].chomp.gsub(/"/,""): ""
    player_team = player[5].present? ? player[5].chomp.gsub(/"/,""): ""

    unless Player.find_by(code: player_code)
      Player.create(
        code: player_code, 
        name: player_firstName+' '+player_lastName, 
        bats: player_bats, 
        throws: player_throws
      )
    end 

    PlayerGame.create(
    code: player_code, 
    league: file_name[13..14],
    year: file_name[16..19].to_i,
    team:  player_team
    )

  end    

  file.close
end 

#Step 3: 
Dir["db/seed_data/*.EVE"].each do |file_name|
  file = File.new(file_name, "r")

  file.each do |line| 
    player = line.split(",")

    if player[0]=="start"
      player_record = PlayerGame.where("code = ? AND year = ?", player[1], file_name[13..16])
      player_record[0].starter = true
      player_record[0].starter_position = player[5].chomp.gsub(/"/,"").to_i
      player_record[0].save
      # (starter: true, starter_position: )
    end 

  end 

  file.close
end 
