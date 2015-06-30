class User < ActiveRecord::Base
  acts_as_voter
  has_many :questions
  has_many :answers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :authentication_keys => [:login]

  before_create :create_login

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def create_login
    email = self.email.split(/@/)
    login_taken = User.where(:username => email[0]).first
    unless login_taken
      self.username = email[0]
    else    
      self.username = self.email
    end        
  end

  def to_s
    username
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end
  
end
