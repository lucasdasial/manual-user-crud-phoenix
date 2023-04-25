defmodule PhxDelivery.Repo do
  use Ecto.Repo,
    otp_app: :phx_delivery,
    adapter: Ecto.Adapters.Postgres
end
