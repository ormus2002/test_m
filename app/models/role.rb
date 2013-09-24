class Role < ActiveRecord::Base
  attr_accessible :name

  validates :name,  presence: true, length: { maximum: 50 }

  has_many :user_roles
  has_many :users, :through => :user_roles

end
