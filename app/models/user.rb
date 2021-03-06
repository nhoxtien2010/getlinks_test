class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin
  end
end
