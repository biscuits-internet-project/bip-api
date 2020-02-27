class SongsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_song, only: [:update, :destroy]

  # GET /songs
  def index
    if params[:slugs].present?
      s = Song.includes(:author).where(slug: params[:slugs]).to_a
      songs = SongSerializer.render(s, view: :details)
    else
      songs = Rails.cache.fetch('songs:all') do
        s = Song.includes(:author).order(:title).all.to_a
        SongSerializer.render(s)
      end
    end

    render json: songs
  end

  # GET /songs/1
  def show
    song = begin
      if params[:edit]
        SongSerializer.render(Song.find(params[:id]), view: :details)
      else
        Rails.cache.fetch("songs:#{params[:id]}") do
          s = Song.find(params[:id])
          s.generate_history_links
          SongSerializer.render(s, view: :details)
        end
      end
    end
    render json: song
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
      params.permit(:title, :cover, :notes, :lyrics, :tabs, :author_id, :history, :featured_lyric)
    end
end
