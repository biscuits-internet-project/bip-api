class HealthController < ApplicationController
  def index
    render json: {"ping" => "pong"}
  end

  def clear
    ClearCacheJob.perform_later
    render json: {"clear" => "true"}
  end
end