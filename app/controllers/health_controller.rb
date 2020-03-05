class HealthController < ApplicationController
  def show
    render json: {"ping" => "pong"}
  end

  def cache_clear
    ClearCacheJob.perform_later
    render json: {"clear" => "true"}
  end
end