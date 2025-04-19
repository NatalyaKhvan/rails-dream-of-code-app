class AdminDashboardController < ApplicationController
  def index
    # debugger

    today = Date.today
    @current_trimester = Trimester.current(today).first
    @upcoming_trimester = Trimester.upcoming(today).first
  end
end
