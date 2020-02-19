class ShowPhotosController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  # GET /shows/:id/:photos
  def index
    show = Show.find(params[:id])
    photos = show.show_photos.includes(image_attachment: :blob)

    render json: ShowPhotoSerializer.render(photos)
  end

end
