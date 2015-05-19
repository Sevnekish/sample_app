class Micropost < ActiveRecord::Base
  belongs_to :user
  # Used to set the default order in which elements are retrieved from the database.
  default_scope -> { order(created_at: :desc) } # order('created_at DESC')
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
