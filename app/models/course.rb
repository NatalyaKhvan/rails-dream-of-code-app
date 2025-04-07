class Course < ApplicationRecord
  belongs_to :coding_class
  belongs_to :trimester
  has_many :enrollments

  def student_name_list
    names_list = []
    enrollments.each do |enrollment|
      names_list << "#{enrollment.student.first_name} #{enrollment.student.last_name}"
    end

    names_list
  end

  def student_email_list
    emails_list = []
    enrollments.each do |enrollment|
      emails_list << enrollment.student.email
    end

    emails_list
  end
end
