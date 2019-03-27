class Visit < ApplicationRecord
  def add_login(login)
    return if logins.include?(login)

    update_column(:logins, logins << login)
  end
end
