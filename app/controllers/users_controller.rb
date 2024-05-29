class UsersController < ApplicationController
  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.role ||= :user

    if @user.save
      session[:user_id] = @user.id
      redirect_to questions_path, notice: 'Ви успішно зареєструвались!'
    else
      flash.now[:alert] = 'Ви неправильно заповнили поле форми реєстрації'

      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_path, notice: 'Дані користувача обновлено'
    else
      flash.now[:alert] = 'При спробі зберегти користувача виникли помилки'

      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.destroy

    redirect_to questions_path, notice: 'Користувач видалений'
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
  end

  private

  def  user_params 
    params.require(:user).permit(
    :name, :nickname, :email, :password, :password_confirmation, :role
    )
  end
end
