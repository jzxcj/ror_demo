class FetchIpsWithMultiplyUsers
  prepend SimpleCommand

  def call
    extract_ips_with_user_lists
  end

  private

  def extract_ips_with_user_lists
    Visit.where('array_length(logins, 1) > 1').order(id: :desc)
  end
end
