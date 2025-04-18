require 'rails_helper'

RSpec.describe "Courses", type: :request do

  before do
    @coding_class = CodingClass.create!(
      title: "Ruby on Rails"
    )
    @current_trimester = Trimester.create!(
      year: "2025",
      term: "Spring",
      application_deadline: "2025-01-01",
      start_date: "2025-03-01",
      end_date: "2025-06-01"
    )
    @course = Course.create!(
      coding_class: @coding_class,
      trimester: @current_trimester,
      max_enrollment: 25
    )
    @student1 = Student.create!(
      first_name: "John",
      last_name: "Smith",
      email: "john@test.com"
    )
    @student2 = Student.create!(
      first_name: "Jane",
      last_name: "Clark",
      email: "jane@test.com"
    )
    Enrollment.create!(
        student: @student1,
        course: @course,
        final_grade: nil
    )
    Enrollment.create!(
        student: @student2,
        course: @course,
        final_grade: nil
    )
  end

  describe "GET /courses/:id" do
    it "returns the course name and at least one student name" do
      # Send a GET request to the course show page
      get course_path(@course)

      # Check for successful response
      expect(response).to have_http_status(:ok)

      # Check if course name is included in the response
      expect(response.body).to include(@course.coding_class.title)

      # Check if student names are included in the response
      expect(response.body).to include(@student1.first_name)
      expect(response.body).to include(@student2.first_name)
    end
  end
end
