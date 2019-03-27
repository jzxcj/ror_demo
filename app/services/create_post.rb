class CreatePost
  prepend SimpleCommand

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def call
    if attributes_valid?
      create_post
      create_visit

      post
    else
      collect_errors
    end
  end

  private

  attr_reader :post

  def attributes_valid?
    validator.valid?
  end

  def create_post
    @post = user.posts.create(post_attributes)
  end

  def create_visit
    ActiveRecord::Base.transaction do
      visit = Visit.find_or_create_by(ip: ip) do |v|
        v.logins = [login]
      end

      visit.reload.lock!
      visit.add_login(login)
    end
  rescue ActiveRecord::RecordNotUnique
    # :nocov:
    retry
    # :nocov:
  end

  def user
    ActiveRecord::Base.transaction do
      User.find_or_create_by(login: login)
    end
  rescue ActiveRecord::RecordNotUnique
    # :nocov:
    retry
    # :nocov:
  end

  def post_attributes
    attributes.slice(:title, :body, :ip)
  end

  def ip
    @ip ||= attributes[:ip]
  end

  def login
    @login ||= attributes[:login]
  end

  def collect_errors
    errors.add_multiple_errors validator.errors.messages
  end

  def validator
    @validator ||= self.class.validator_class.new(attributes)
  end

  def self.validator_class
    @validator_class ||= CreatePostParamsValidator
  end

  class << self
    attr_writer :validator_class
  end
end
