class AuthorsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_author, only: [:show, :update, :destroy]

  # GET /authors
  def index
    authors = Author.order(:name).all

    render json: AuthorSerializer.render(authors)
  end

  # GET /authors/1
  def show
    render json: AuthorSerializer.render(@author)
  end

  # POST /authors
  def create
    author = Author.new(author_params)

    if author.save
      render json: AuthorSerializer.render(author), status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render json: AuthorSerializer.render(@author)
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    @author.destroy
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.permit(:name)
    end
end
