class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # also available are: :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :groups
  validates :username, :password, presence: true
  validates :username, uniqueness: true

  # These email methods are here to over-ride built in email functionality in Devise. 
  # Without them, Devise would cause authentication errors.
  def email_required?
    false
  end

  def email_changed?
    false
  end

end
