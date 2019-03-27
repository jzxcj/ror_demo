class PostDecorator < Draper::Decorator
  delegate_all

  def ip
    object.ip.to_string
  end

  def as_json(*_args)
    { id: id, title: title, body: body, login: user.login, ip: ip }
  end
end
