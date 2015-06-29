class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question


  respond_to :html, :json 

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @user = current_user
    @question = Question.find(params[:question_id])
    @answer = @user.answers.new(answer_params)
    @answer.question_id = @question.id
    if @answer.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Answer posted!"
          redirect_to question_path(@question)
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:alert] = "Error. Answer not posted!"
          redirect_to :back
        end
        format.js
      end
    end
  end

  def show
    @question = Answer.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      flash[:notice] = "Answer updated."
      respond_with @answer
    else
      flash[:alert] = "Error. Answer not updated."
      redirect_to :back
    end
  end

private
  def set_question
      @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:contents)
  end
end
