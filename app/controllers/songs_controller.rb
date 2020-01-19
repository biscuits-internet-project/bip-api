class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]
  before_action :authenticate!, only: [:create, :update, :destroy]

  # GET /songs
  def index
    songs = Song.includes(:author).all

    render json: SongSerializer.render(songs)
  end

  # GET /songs/1
  def show
    render json: SongSerializer.render(@song)
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
