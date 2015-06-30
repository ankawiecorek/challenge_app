class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true

  after_update :answer_mailer

  private

  def answer_mailer
    AnswerMailer.accepted_notification(self).deliver
  end



end
