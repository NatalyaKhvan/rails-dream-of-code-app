require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'when trimesters exist' do
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
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end

    context 'when no trimesters exist' do
      it 'returns a page with title Trimesters and no <li> tags' do
        get '/trimesters'
        expect(response.body).to include('<title>Trimesters</title>')
        expect(response.body).not_to include('<li>')
      end
    end
  end

  describe "GET /trimesters/:id/edit" do
    it "renders the edit form with the application_deadline label" do
      trimester = Trimester.create!(
        term: "Fall",
        year: 2025,
        application_deadline: "2025-08-01",
        start_date: "2025-09-01",
        end_date: "2025-12-15"
      )

      get edit_trimester_path(trimester)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("application_deadline")
    end
  end

  describe "PUT /trimesters/:id" do
    let!(:trimester) { Trimester.create!(
      term: "Fall",
      year: 2025,
      application_deadline: "2025-08-01",
      start_date: "2025-09-01",
      end_date: "2025-12-15"
    ) }

    context "with valid application_deadline" do
      it "updates the trimester and redirects" do
        put trimester_path(trimester), params: {
          trimester: { application_deadline: "2025-01-15" }
        }

        expect(response).to have_http_status(:found)
        expect(trimester.reload.application_deadline).to eq(Date.parse("2025-01-15"))
        expect(response).to redirect_to(trimester_path(trimester))
        expect(flash[:notice]).to eq("Trimester updated successfully.")
      end
    end

    context "without application_deadline" do
      it "redirects to the edit page with an alert message" do
        put trimester_path(trimester), params: { trimester: { application_deadline: nil } }

        # Expect redirection to the edit page
        expect(response).to redirect_to(edit_trimester_path(trimester))

        # Check for the correct alert message
        follow_redirect!
        expect(flash[:alert]).to eq("Please correct the errors and submit again.")
      end
    end

    context "with invalid application_deadline format" do
      it "redirects to the edit page with an alert message" do
        put trimester_path(trimester), params: { trimester: { application_deadline: "invalid_date" } }

        # Expect redirection to the edit page
        expect(response).to redirect_to(edit_trimester_path(trimester))

        # Check for the correct alert message
        follow_redirect!
        expect(flash[:alert]).to eq("Please correct the errors and submit again.")
      end
    end    
  end
end
