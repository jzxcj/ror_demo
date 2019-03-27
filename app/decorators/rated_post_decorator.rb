class RatedPostDecorator < Draper::Decorator
  delegate_all

  # def ip
  #   object.ip.to_string
  # end

  def as_json(*_args)
    { id: object['id'], title: object['title'], body: object['body'], average_rating: object['avg_rating'] }
  end
end
