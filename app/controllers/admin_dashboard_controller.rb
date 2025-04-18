class AdminDashboardController < ApplicationController
  def index
    # debugger
    @current_trimester = Trimester.where("start_date <= ?", Date.today).where("end_date >= ?", Date.today).first
    @upcoming_trimester = Trimester.where("start_date > ? AND start_date <= ?", Date.today, Date.today + 6.months).first
  end
end
