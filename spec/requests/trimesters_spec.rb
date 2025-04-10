require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01',
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        puts response.body
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context 'trimesters do not exist' do
        it 'returns a page with title Trimesters and no <li> tags' do
          get '/trimesters'
          puts response.body
          expect(response.body).to include('<title>Trimesters</title>')
          expect(response.body).not_to include('<li>')
        end
    end
  end
end