class GamesController < ApplicationController

  def create
    game = Game.create

    if (params[:game][:word].blank?)
      game.word = game.random_word
    else
      game.word = params[:game][:word].downcase
    end

    game.lives = params[:game][:lives]

    game.hidden = true

    game.save

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
  
end
