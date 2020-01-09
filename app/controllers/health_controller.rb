class HealthController < ApplicationController
  def show
    render json: {"ping" => "pong"}
  end
end