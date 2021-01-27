class Api::V1::SessionsController < ApplicationController
  def whoami
    render json: current_user, status: :ok
  end
end
