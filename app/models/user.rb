class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :fio, :dr, :user_role

  validates :fio,  presence: true, length: { maximum: 50 }

  has_one :user_role, :dependent => :destroy
  has_one :role, :through => :user_role

end
