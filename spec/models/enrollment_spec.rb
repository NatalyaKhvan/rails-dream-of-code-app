require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe '#is_past_application_deadline?' do
    let(:trimester) do
      Trimester.create(
        year: '2025',
        term: 'Spring',
        application_deadline: Date.new(2025, 3, 1),
        start_date: Date.new(2025, 3, 10),
        end_date: Date.new(2025, 6, 10)
      )
    end
    let(:coding_class) do
      CodingClass.create(
        title: 'Ruby on Rails'
      )
    end
    let(:course) do
      Course.create(
        coding_class_id: coding_class.id,
        trimester: trimester,
        max_enrollment: 30
      )
    end
    let(:student) do
      Student.create(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@test.com'
      )
    end
    let(:enrollment1) do
      Enrollment.create(
        course: course,
        student: student,
        final_grade: nil,
        created_at: Date.new(2025, 2, 28)
      )
    end
    let(:enrollment2) do
      Enrollment.create(
        course: course,
        student: student,
        final_grade: nil,
        created_at: Date.new(2025, 3, 2)
      )
    end

    context 'when enrollment is created before the application deadline' do
      it 'returns false' do
        expect(enrollment1.is_past_application_deadline?).to be false
      end
    end

    context 'when enrollment is created after the application deadline' do
      it 'returns true' do
        expect(enrollment2.is_past_application_deadline?).to be true
      end
    end
  end
end
