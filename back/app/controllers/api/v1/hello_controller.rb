class Api::V1::HelloController < ApplicationController
  def index
    render json: "Hello"
  end
end
