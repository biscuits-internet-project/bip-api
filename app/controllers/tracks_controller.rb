class TracksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:update]
  before_action :set_track, only: [:show, :update]

  # GET /tracks/song/:id
  def index
    song = Song.find(params["song_id"])
    tracks = Track.includes(:annotations, show: :venue).where(song_id: song.id).order('shows.date').to_a

    render json: TrackSerializer.render(tracks, view: :versions)
  end

  # GET /tracks/1
  def show
    render json: TrackSerializer.render(@track)
  end

  # PATCH/PUT /tracks/1
  def update
    if @track.update(track_params)
      render json: TrackSerializer.render(@track, view: :versions)
    else
      render json: @track.errors, status: :unprocessable_entity
    end
  end

  private
    def set_track
      @track = Track.find(params[:id])
    end

    def track_params
      params.permit(:set, :segue, :position, :note)
    end
end
