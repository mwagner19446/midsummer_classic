class PlayerController < ApplicationController
  def add
    # @player = PlayerGame.where(code: params[:code])
    @player= Player.where(code: params[:keyword])
    @playergame = PlayerGame.where(code: params[:keyword])
    
    @tasks = []

    @playergame.each do |game|
      
      @starter = game.starter_position.nil? ? "RESERVE" : "STARTER" 
      @game = {startDate: game.year, endDate: game.year+1, taskName: @player[0].name, status: @starter}
      @tasks << @game
    end 

    render json: @tasks
  end 

  def all
    @player = Player.all
    # @player = @player.map! do |player| player.name end

    render json: @player
  end 

end 

# {"startDate":new Date("1990"),"endDate":new Date("1991"),"taskName":"Lenny Dykstra","status":"STARTER"}