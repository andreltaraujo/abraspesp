class User < ApplicationRecord
  belongs_to :contract
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :first_name, presence: true, length: {minimum: 3}
  validates :last_name, presence: true, length: {minimum: 3}
  
  # Virtual_Attributes
  def full_name
    [self.first_name, self.last_name].join(' ')
  end
end
