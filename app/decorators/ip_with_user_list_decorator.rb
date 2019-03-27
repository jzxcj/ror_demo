class IpWithUserListDecorator < Draper::Decorator
  delegate_all

  def ip
    object.ip.to_string
  end

  def as_json(*_args)
    { ip: ip, logins: logins }
  end
end
