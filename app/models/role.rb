class Role < ActiveRecord::Base
  attr_accessible :name

  validates :name,  presence: true, length: { maximum: 50 }

  has_many :users

end
