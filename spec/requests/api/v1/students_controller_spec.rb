require 'rails_helper'

RSpec.describe 'Api::V1::Students', type: :request do
  describe 'POST /api/v1/students' do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@example.com'
        }
      }
    end

    let(:invalid_attributes) do
      {
        student: {
          first_name: '',  # invalid blank first_name
          last_name: 'Smith',
          email: 'invalid@example.com'
        }
      }
    end

    before do
      # create existing student to test duplicate email validation
      Student.create!(
        first_name: 'Existing',
        last_name: 'User',
        email: 'duplicate@example.com'
      )
    end

    it 'creates a new student' do
      expect do
        post '/api/v1/students', params: valid_attributes
      end.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq('validstudent@example.com')
    end

    context 'with invalid parameters' do
      it 'returns errors when first_name is blank' do
        post '/api/v1/students', params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("First name can't be blank")
      end

      it 'returns errors when email is already taken' do
        post '/api/v1/students', params: {
          student: {
            first_name: 'New',
            last_name: 'User',
            email: 'duplicate@example.com'
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Email has already been taken")
      end
    end
  end
end
