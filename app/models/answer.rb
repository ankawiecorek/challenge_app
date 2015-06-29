class Answer < ActiveRecord::Base
  acts_as_votable
  belongs_to :question
  belongs_to :user

  validates :content, presence: true

  after_create :answer_mailer

private

  def answer_mailer
    AnswerMailer.answer_notification(self).deliver
  end
end
