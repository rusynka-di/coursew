class AdminsController < ApplicationController
  def page
    @users = User.all
  end

  def create
    # Ваш код для створення адміністратора
  end
end
