class SongsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /songs
  def index
    songs = Rails.cache.fetch('Song.all') { SongSerializer.render(Song.includes(:author).order(:title).all.to_a) }

    render json: songs
  end

  # GET /songs/1
  def show
    render json: SongSerializer.render(@song, view: :details)
  end

  # POST /songs
  def create
    song = Song.new(song_params)

    if song.save
      render json: SongSerializer.render(song), status: :created
    else
      render json: song.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/1
  def update
    if @song.update(song_params)
      render json: SongSerializer.render(@song)
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # DELETE /songs/1
  def destroy
    @song.destroy
  end

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.permit(:title, :cover, :notes, :lyrics, :tabs, :author_id)
    end
end
