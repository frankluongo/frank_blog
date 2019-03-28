defmodule FrankBlog.Repo do
  use Ecto.Repo,
    otp_app: :frank_blog,
    adapter: Ecto.Adapters.Postgres
end
