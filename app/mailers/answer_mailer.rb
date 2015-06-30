class AnswerMailer < ApplicationMailer

  default from: "anka@noreply.co"

  def answer_notification(answer)
    @answer = answer

    mail to: answer.question.user.email, subject: "Answer notification"
  end

  def accepted_notification(answer)
  	
  	@answer = answer

  	mail to: answer.user.email, subject: "Accepted notification"
  	
  end

end
