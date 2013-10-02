class UploadedFile < ActiveRecord::Base
  attr_accessible :mydoc, :name, :user_id

  before_create :default_name

  belongs_to :user

  mount_uploader :mydoc, FileUploader

  scope :desc, order("created_at DESC")

  def default_name
    self.name ||= File.basename(mydoc.filename) if mydoc

  end

end
