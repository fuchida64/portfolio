require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
    describe '会員登録' do
      context "会員登録ページが正しく表示される" do
        before do
          get :new
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
            expect(response.body).to include("会員登録")
        end
      end
      context "会員登録できる" do
      end
    end
end