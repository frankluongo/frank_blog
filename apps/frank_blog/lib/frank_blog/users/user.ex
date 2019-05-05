defmodule FrankBlog.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :encrypted_password, :string
    field :username, :string

    has_many :articles, FrankBlog.Article

    timestamps()
  end
end
