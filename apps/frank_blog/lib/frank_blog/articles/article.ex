defmodule FrankBlog.Article do
  use Ecto.Schema

  schema "articles" do
    field :title, :string
    field :body, :string
    field :slug, :string

    belongs_to :user, FrankBlog.User

    timestamps()
  end
end
