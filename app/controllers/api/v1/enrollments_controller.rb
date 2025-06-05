class Api::V1::EnrollmentsController < ApplicationController
    # Static data
    # def index
    #     enrollments_hash = {
    #         enrollments: [
    #             {
    #                 id: 278,
    #                 studentId: 68,
    #                 studentFirstName: "Bob",
    #                 studentLastName: "Burger",
    #                 finalGrade: ""
    #             },
    #             {
    #                 id: 302,
    #                 studentId: 89,
    #                 studentFirstName: "Marge",
    #                 studentLastName: "Simpson",
    #                 finalGrade: ""
    #             },
    #         ]
    #     }

    #     render json: enrollments_hash, status: :ok
    # end

    # Dynamic data
    # When collecting the data to respond. Use these steps to guide you:

    # Get the courses for the current trimester
    # For each of the courses in the current trimester, loop through the enrollments and create a hash of data as outlined in the example data in the lesson.
    # Add each of the hash elements to the enrollments key of the main hash and pass it to respond_to.

    def index
        if params[:course_id].present?
            # Enrollments for a specific course
            course = Course.includes(enrollments: :student).find_by(id: params[:course_id])
            return render json: { enrollments: [] }, status: :not_found unless course

            enrollments_hash = { enrollments: [] }

            course.enrollments.each do |enrollment|
                enrollments_hash[:enrollments] << enrollment_json(enrollment)
            end

            render json: enrollments_hash, status: :ok
        else

            # Enrollments for all courses in current trimester
            current_trimester = Trimester.current.first
            return render json: { enrollments: [] }, status: :not_found unless current_trimester

            courses = current_trimester.courses.includes(enrollments: :student)

            enrollments_hash = { enrollments: [] }

            courses.each do |course|
                course.enrollments.each do |enrollment|
                    enrollments_hash[:enrollments] << {
                        id: enrollment.id,
                        studentId: enrollment.student.id,
                        studentFirstName: enrollment.student.first_name,
                        studentLastName: enrollment.student.last_name,
                        finalGrade: enrollment.final_grade
                    }
                end
            end

            render json: enrollments_hash, status: :ok
        end
    end
end