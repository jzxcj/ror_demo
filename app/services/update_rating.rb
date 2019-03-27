class UpdateRating
  prepend SimpleCommand

  attr_reader :post, :rate

  def initialize(post, rate)
    @post = post
    @rate = rate
  end

  def call
    post.transaction do
      post.reload.lock!

      add_rating
      update_avg_rating
    end

    post.avg_rating
  end

  private

  def add_rating
    post.ratings.create(rate: rate)
  end

  def update_avg_rating
    post.update_avg_rating
  end
end
