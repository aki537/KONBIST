require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'フード作成' do
    food = create(:food, name: 'おにぎり')
    expect(food).to be_valid
  end
end
