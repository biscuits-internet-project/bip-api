class HealthController < ApiController
  def show
    render json: {"ping" => "pong"}
  end
end