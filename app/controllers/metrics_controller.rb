class MetricsController < ApplicationController
  before_action :authorize_admin, only: [:create]

  # POST /metrics
  def index
    command = MetricsGet.call

    if command.success?
      render json: command.result, status: :ok
    else
      render json: command.errors, status: :unprocessable_entity
    end
  end
end
