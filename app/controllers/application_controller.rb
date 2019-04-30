class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Overriding Devise Sign in Methods
  
  def after_sign_in_path_for(resource)
    new_game_url
  end

  def after_sign_out_path_for(resource)
    new_game_url
  end


end
