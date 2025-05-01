class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_many :mentor_enrollment_assignments

  def student_name
    "#{student.first_name} #{student.last_name}"
  end

  def is_past_application_deadline?
    created_at > course.trimester.application_deadline
  end
end
