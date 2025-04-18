class Trimester < ApplicationRecord
  has_many :courses

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  # Scope to get the current trimester
  scope :current, -> {
    where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
  }

  # Scope to get the upcoming trimester
  scope :upcoming, -> {
    where('start_date > ?', Date.today).order(:start_date)
  }
end
