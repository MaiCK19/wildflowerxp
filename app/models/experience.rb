class Experience < ApplicationRecord
  DEFAULT_IMG = 'https://res.cloudinary.com/geuxor/image/upload/v1615381828/samples/sheep-closeup-eating-grass_bbalee.jpg'
  ACTIVITIES = %w( Food Sport Culture Nature Animals Wild Danger )
  ACTIVITY_EFFORTS = (1..5)
  has_one_attached :photo
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  
  validates :title, :description, :location, :price, :activity, :max_guests, :meeting_point, :policies, :activity_effort, presence: true
  validates :price, :max_guests, numericality: true
  validates :activity, inclusion: { in: ACTIVITIES }
  validates :activity_effort, inclusion: { in: ACTIVITY_EFFORTS }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
