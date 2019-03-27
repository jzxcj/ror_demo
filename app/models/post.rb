class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings

  delegate :login, to: :user

  def update_avg_rating
    update_column(:avg_rating, ratings.average(:rate))
  end
end
