class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  enum :status, [ :pending, :accepted, :declined, :canceled ]
  # Scope are called on the Class
  scope :pending, -> { where(status: "pending") }
  scope :accepted, -> { where(status: "accepted") }
  scope :declined, -> { where(status: "declined") }
  scope :canceled, -> { where(status: "canceled") }

  before_validation :set_status

  private

  def set_status
    self.status = "pending"
  end
end
