class FetchTopRatedPosts
  prepend SimpleCommand

  attr_reader :size

  def initialize(size)
    @size = size
  end

  def call
    extract_top_rated_posts
  end

  private

  def extract_top_rated_posts
    Post.connection.select_all('SELECT id, title, body, avg_rating FROM posts ORDER BY avg_rating DESC, created_at DESC LIMIT $1', nil, [[nil, size]]).to_hash

    # Post.order(avg_rating: :desc, created_at: :desc).limit(size)
  end
end
