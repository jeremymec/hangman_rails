class GamesController < ApplicationController

  def create
    game = Game.create(game_params)
    redirect_to(game)
  end

  def reveal_word
    game = Game.find_by slug: params[:slug]
    game.hidden = false
    game.save

    redirect_to(game)
  end

  def hide_word
    game = Game.find_by slug: params[:slug]
    game.hidden = true
    game.save

    redirect_to(game)
  end

  def show
    @game = Game.find_by slug: params[:slug]
  end

  private

  def game_params
    params[:game][:word] = params[:game][:word]&.presence || Game.random_word(params[:game][:difficulty])
    params[:game][:hidden] = true
    params[:game]
    params.require(:game).permit(:word, :hidden, :difficulty, :lives)
  end
  
end


