defmodule Tabby.Repo do
  use Ecto.Repo,
    otp_app: :tabby,
    adapter: Ecto.Adapters.Postgres
end
