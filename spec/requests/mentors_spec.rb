require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'when mentors exist' do
      before do
          Mentor.create!(
            first_name: "John",
            last_name: "Smith",
            email: "john@test.com",
            max_concurrent_students: 5
          )
          Mentor.create!(
            first_name: "Kathy",
            last_name: "Smith",
            email: "kathy@test.com",
            max_concurrent_students: 5
          )
        end

      it 'returns a page containing names of all mentors' do
        get '/mentors'
        expect(response.body).to include('John')
        expect(response.body).to include('Kathy')
      end
    end

    context 'when no mentors exist' do
      it 'returns a page with a title and no mentor details' do
        get '/mentors'
        expect(response.body).to include('<title>Mentors</title>')
        expect(response.body).not_to include('<li>')
        expect(response.body).not_to include('<div id="mentor">')
      end
    end
  end

  describe "GET /mentors/:id" do
    context 'when a mentor exists' do
      let(:mentor) { Mentor.create!(
                       first_name: "John",
                       last_name: "Smith",
                       email: "john@test.com",
                       max_concurrent_students: 5
                     ) }

      it 'returns a page showing the mentor details' do
        within '#mentor_1' do
            expect(response.body).to include('First name: John')
            expect(response.body).to include('Last name: Smith')
            expect(response.body).to include('Email: john@test.com')
            expect(response.body).to include('Max concurrent students: 5')
            end
        end
    end

    context 'when the mentor does not exist' do
      it 'returns a 404 page' do
        get mentor_path(id: 999)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end