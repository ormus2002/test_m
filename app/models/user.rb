class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :fio, :dr, :role_id, :group_id, :manager_id, :visible_for_bux

  validates :fio,  presence: true, length: { maximum: 50 }

  belongs_to :role
  belongs_to :group

  has_many :subordinates, class_name: "User",
           foreign_key: "manager_id"

  belongs_to :manager, class_name: "User"

  has_many :uploaded_files
end
