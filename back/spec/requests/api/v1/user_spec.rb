require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'User' do
    before(:each) do
      @user = create(:user)
    end

    it 'ユーザー一覧取得' do
      get '/api/v1/users/'
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(response.status).to eq(200)
    end

    it '特定ユーザー取得' do
      get "/api/v1/users/#{@user.id}"
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(json['email']).to eq(@user.email)
    end
  end
end
