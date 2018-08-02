require 'rails_helper'

RSpec.describe HomesController, type: :controller do
    describe 'TOPページ' do
      context "TOPページが正しく表示される" do
        before do
          get :index
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
            expect(response.body).to include("TOP")
        end
      end
    end
end