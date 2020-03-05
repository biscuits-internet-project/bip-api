class TracksController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:update]
  before_action :set_track, only: [:show, :update]

  # GET /tracks/song/:id
  def index
    song = Song.find(params["song_id"])

    tracks = Rails.cache.fetch("song:#{song.slug}:tracks") do
      tracks = Track.includes(:track_tag_taggings, :track_tags, :annotations, :venue, :show).where(song_id: song.id).order('shows.date').to_a
      TrackSerializer.render(tracks, view: :versions)
    end

    render json: tracks
  end

  # GET /tracks/1
  def show
    render json: TrackSerializer.render(@track)
  end

  # PATCH/PUT /tracks/1
  def update
    if params[:track_tag_list]
      @track.track_tag_list = params[:track_tag_list]
      @track.save
    end
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
      params.except(:track_tag_list).permit(:set, :segue, :position, :note, :all_timer)
    end
end
