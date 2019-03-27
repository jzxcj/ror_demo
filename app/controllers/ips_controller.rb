class IpsController < ApplicationController
  def index
    fetching = FetchIpsWithMultiplyUsers.()

    render json: IpWithUserListDecorator.decorate_collection(fetching.result), status: :ok
  end
end
