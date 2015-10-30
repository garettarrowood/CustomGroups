class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups






  # these email methods are here to over-ride built in email functionality in Devise. Without them, Devise would cause authentication errors.
  def email_required?
    false
  end

  def email_changed?
    false
  end

end
