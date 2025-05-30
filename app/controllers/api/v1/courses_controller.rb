class Api::V1::CoursesController < ApplicationController
  # Static data
  # def index
  #   courses_hash = {
  #     courses: [
  #       {
  #         id: 55,
  #         title: "Intro to Programming",
  #         application_deadline: "2025-01-15",
  #         start_date: "2025-01-15",
  #         end_date: "2025-01-15"
  #       },
  #       {
  #         id: 61,
  #         title: "Ruby on Rails",
  #         application_deadline: "2025-01-15",
  #         start_date: "2025-01-15",
  #         end_date: "2025-01-15"
  #       }
  #     ]
  #   }

  #   render json: courses_hash, status: :ok
  # end

  # Dynamic data
  # Follow these steps to replace the static data with live data:

  # Get the list of courses in the current trimester.
  # Loop through the list of courses and create a hash in the shape above.
  # In the loop, add each hash to an array.
  # Assign the array to the courses key of the hash to be passed to the render method (courses_hash)

  def index
    current_trimester = Trimester.current.first
    return render json: { courses: [] }, status: :not_found unless current_trimester

    courses = current_trimester.courses
    
    courses_hash = {
      courses: courses.map do |course|
        {
          id: course.id,
          title: course.coding_class.title,
          application_deadline: course.trimester.application_deadline.to_s,
          start_date: course.trimester.start_date.to_s,
          end_date: course.trimester.end_date.to_s
        }
      end
    }

    render json: courses_hash, status: :ok
  end
end