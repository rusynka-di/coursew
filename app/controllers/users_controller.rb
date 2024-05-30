class UsersController < ApplicationController
  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)

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

    if current_user == @user
      @user.destroy
      session.destroy
      redirect_to root_path, notice: 'Ваш обліковий запис був успішно видалений'
    elsif current_user.admin?
      @user.destroy
      redirect_to admins_page_path, notice: 'Користувач видалений'
    end
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
  end

  def admin_update_role
    @user = User.find(params[:id])
    if @user.update(admin_params)
      redirect_to admins_page_path, notice: 'Роль користувача оновлено'
    else
      redirect_to admins_page_path, alert: 'Не вдалося оновити роль користувача'
    end
  end

  private

  def  user_params 
    params.require(:user).permit(
    :name, :nickname, :email, :password, :password_confirmation, :role
    )
  end

  def admin_params
    params.require(:user).permit(:admin)
  end
end
