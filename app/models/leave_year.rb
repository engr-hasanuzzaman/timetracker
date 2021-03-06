class LeaveYear < ActiveRecord::Base

  has_many :holiday_schemes, dependent: :destroy

  scope :find_present_year, -> { find_by(present: true) }

end
