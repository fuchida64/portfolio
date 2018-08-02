require 'rails_helper'

RSpec.describe Admins::SessionsController, type: :controller do
    describe '管理者ログイン' do
      context "管理者ログインページが正しく表示される" do
        before do
          get :new
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
            expect(response.body).to include("管理者ログイン")
        end
      end
      context "管理者ログインできる" do
      end
    end
end