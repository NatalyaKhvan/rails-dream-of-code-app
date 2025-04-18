require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
    before do
      @current_trimester = Trimester.create!(
        term: 'Spring',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )
      @past_trimester = Trimester.create!(
        term: 'Fall',
        year: (Date.today.year - 1).to_s,
        start_date: Date.today - 6.months,
        end_date: Date.today - 3.months,
        application_deadline: Date.today - 7.months
      )
      @upcoming_trimester = Trimester.create!(
        term: 'Summer',
        year: (Date.today.year + 1).to_s,
        start_date: Date.today + 3.months,
        end_date: Date.today + 5.months,
        application_deadline: Date.today + 2.months
      )
      @coding_class = CodingClass.create!(
        title: "Ruby on Rails"
      )
      @current_course = Course.create!(
        coding_class: @coding_class,
        trimester: @current_trimester,
        max_enrollment: 25
      )
      @upcoming_course = Course.create!(
        coding_class: @coding_class,
        trimester: @upcoming_trimester,
        max_enrollment: 25
      )
    end

    it 'returns a 200 OK status' do
      # Send a GET request to the dashboard route
      get "/dashboard"

      # Check that the response status is 200 (OK)
      expect(response).to have_http_status(:ok)
    end

    it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@current_trimester.term} - #{@current_trimester.year}")
    end

    it 'displays links to the courses in the current trimester' do
    end

    it 'displays the upcoming trimester' do
      get "/dashboard"
      expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
    end

    it 'displays links to the courses in the upcoming trimester' do
    end

    
  end
end