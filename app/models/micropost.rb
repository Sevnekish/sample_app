class Micropost < ActiveRecord::Base
  belongs_to :user
  # Used to set the default order in which elements are retrieved from the database.
  default_scope -> { order(created_at: :desc) } # order('created_at DESC')
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  # use of validate (as opposed to validates) to call a custom validation.
  validate :picture_size

  private

    # Validates the size of an uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
