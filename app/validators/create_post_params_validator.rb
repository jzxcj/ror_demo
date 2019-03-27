class CreatePostParamsValidator
  include ActiveModel::Model

  attr_accessor :title, :body, :login, :ip

  validates :title, :body, :login, :ip, presence: true
  validate :ip_should_be_valid

  private

  def ip_should_be_valid
    IPAddr.new(ip)
  rescue IPAddr::Error
    errors.add(:ip, 'Invalid ip address')
  end
end
