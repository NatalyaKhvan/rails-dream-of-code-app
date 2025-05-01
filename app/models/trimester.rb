class Trimester < ApplicationRecord
  has_many :courses

  def display_name
    "#{term} #{year}"
  end

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :application_deadline, presence: true

  # Scope to get the current trimester
  scope :current, ->(date = Date.today) {
  where('start_date <= ? AND end_date >= ?', date, date)
  }

  # Scope to get the upcoming trimester
  scope :upcoming, ->(date = Date.today) {
  where('start_date > ?', date).order(:start_date)
  }
end
