class MediaContentsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_media_content, only: [:show, :update, :destroy]

  # GET /media_contents
  def index
    @media_contents = MediaContent.all.order("date desc, year desc")

    render json: @media_contents
  end

  # GET /media_contents/1
  def show
    render json: @media_content
  end

  # POST /media_contents
  def create
    @media_content = MediaContent.new(media_content_params)

    if @media_content.save
      render json: @media_content, status: :created, location: @media_content
    else
      render json: @media_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media_contents/1
  def update
    if @media_content.update(media_content_params)
      render json: @media_content
    else
      render json: @media_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /media_contents/1
  def destroy
    @media_content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_content
      @media_content = MediaContent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def media_content_params
      params.permit(:date, :year, :url, :description, :media_type)
    end
end
