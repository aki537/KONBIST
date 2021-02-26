require 'rails_helper'

RSpec.describe Food, type: :request do
  describe 'Food' do
    before(:each) do
      @food = create(:food)
      @foods = create_list(:food ,10)
    end

    it '全てのフードを取得' do
      get '/api/v1/foods'
      json = JSON.parse(response.body)

      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end

    it '特定のフードを取得' do
      get "/api/v1/foods/#{@food.id}"
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      # 要求した特定のフードのみ取得した事を確認する
      expect(json['name']).to eq(@food.name)
    end

    # it '新しいフード作成' do
    #   food_params = { name: 'foodtest', }
  
    #   #データが作成されている事を確認
    #   expect { post '/api/v1/foods', params: food_params }.to change(Food, :count).by(+1)
  
    #   # リクエスト成功を表す200が返ってきたか確認する。
    #   expect(response.status).to eq(200)
    # end

    it 'フード編集' do
      food = create(:food, name: 'old-title')
  
      put "/api/v1/foods/#{food.id}", params: {name: 'new-title'} 
      json = JSON.parse(response.body)
  
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
  
      #データが更新されている事を確認
      expect(json['name']).to eq('new-title')
   end
   it 'フード削除' do
    food = create(:food)

    #データが削除されている事を確認
    expect { delete "/api/v1/foods/#{food.id}" }.to change(Food, :count).by(-1)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
  end
  end
end
