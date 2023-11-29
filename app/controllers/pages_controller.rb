class PagesController < ApplicationController
  def index
  end

  def inicio
    @user = current_user.id
  end

  
end
