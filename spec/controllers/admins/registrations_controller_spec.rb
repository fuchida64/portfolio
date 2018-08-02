require 'rails_helper'

RSpec.describe Admins::RegistrationsController, type: :controller do
    describe '管理者登録' do
      context "管理者登録ページが正しく表示される" do
        before do
          get :new
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
            expect(response.body).to include("管理者登録")
        end
      end
      context "管理者登録できる" do
      end
    end
end