class GamesController < ApplicationController
  def new

  end

  def create
    game = Game.create(game_params)

    redirect_to(game)
  end

  def reveal_word
    game = Game.find(params[:id])
    game.hidden = false
    game.save

    redirect_to(game)
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params[:game][:word] = params[:game][:word].downcase || game.random_word
    params[:game][:hidden] = true
    params
  end
