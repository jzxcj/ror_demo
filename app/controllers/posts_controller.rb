class PostsController < ApplicationController
  before_action :set_post, only: [:rate]

  def index
    fetching = FetchTopRatedPosts.(params[:size])

    render json: RatedPostDecorator.decorate_collection(fetching.result), status: :ok
  end

  def rate
    updating = UpdateRating.(@post, params[:rate])

    render json: { average_rating: updating.result }, status: :ok
  end

  # curl -d '{"post":{"title":"test","body":"test","ip":"127.0.0.1","login":"test"}}' -H "Content-Type: application/json" -X POST http://localhost:3000/posts
  def create
    creating = CreatePost.(post_params)

    if creating.success?
      render json: PostDecorator.new(creating.result), status: :ok
    else
      render json: { errors: creating.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :login, :ip)
  end
end
