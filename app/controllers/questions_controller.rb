class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update destroy show edit]

  def create
    @question = Question.new(question_params)

    if @question.user_id.blank?
      @question.user_id = current_user.id
    end

    if @question.save
      redirect_to questions_path(@question), notice: 'Нове питання створено!'
    else
      render :new
    end
  end
  
  def update
    @question.update(question_params)
     
    redirect_to questions_path(@question), notice: 'Питання збережене!'
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: 'Питання видалене!'
  end

  def show
    @question = current_user.questions.find(params[:id])
  end

  def index 
    if current_user
      @questions = current_user.questions
    else
      redirect_to new_user_path
    end
  end  

  def new
    @question = current_user.questions.build
  end

  def edit
      
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
