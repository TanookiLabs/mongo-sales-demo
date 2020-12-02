class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1, developer: 2 }

  validates :role, :first_name, :last_name, :email, presence: true

  def superuser?
    admin? || developer?
  end

  def full_name
    [first_name.presence, last_name.presence].compact.join(' ')
  end
end
