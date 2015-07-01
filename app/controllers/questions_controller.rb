class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    
  end

  def create
    @user = current_user
    @question = @user.questions.new(question_params)
    @question.user.points -= 10
    if @question.save
      @question.user.save
      respond_to do |format|
        format.html do
          flash[:success] = "Question successfully added."
          redirect_to questions_path
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:alert] = "There was a problem adding your question."
          redirect_to :back
        end
        format.js
      end
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      @answer = Answer.find(@question.best_answer_id)
      flash[:success] = "Answer updated."
      respond_with @question
      @answer.user.points += 25
      @answer.user.save
    else
      flash[:alert] = "Error. Answer not updated."
      redirect_to :back
    end
  end

  def destroy
    @question = Question.destroy(params[:id])
      respond_to do |format|
        flash[:danger] = "Your question was removed."
        format.html { redirect_to questions_path }
        format.js
      end
  end

  private
  def set_question
      @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content, :best_answer_id)
  end
end
