defmodule LearnAbsinthe.Repo do
  use Ecto.Repo,
    otp_app: :learn_absinthe,
    adapter: Ecto.Adapters.Postgres
end
