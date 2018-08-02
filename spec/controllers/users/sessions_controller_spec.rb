require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
    describe 'ログイン' do
      context "ログインページが正しく表示される" do
        before do
          get :new
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
            expect(response.body).to include("ログイン")
        end
      end
      context "ログインできる" do
      end
    end
end