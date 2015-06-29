class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
end
