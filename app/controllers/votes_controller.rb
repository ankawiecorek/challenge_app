class VotesController < ApplicationController

  def update
    @answer = Answer.find(params[:id])
    if params[:type] == "up"
      @user = @answer.user
      @answer.upvote_from current_user
      @user.points += 5
      @user.save
    end
    if params[:type] == "down"
      @answer.downvote_from current_user
    end
    respond_to do |format|
      format.html do
        redirect_to question_path(@answer.question)
      end
      format.js
    end
  end
  
end
