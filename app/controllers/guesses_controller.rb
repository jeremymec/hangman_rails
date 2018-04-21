class GuessesController < ApplicationController

  def create
    game = Game.find(params[:game_id])
    @guess = game.guesses.create(guess_parameters)
    redirect_to(game)

  end

end

private

def guess_parameters
  params.permit(:letter)
end
