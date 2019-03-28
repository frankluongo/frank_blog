defmodule FrankBlog.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Bcrypt
  alias FrankBlog.User

  schema "users" do
    field :encrypted_password, :string
    field :username, :string

    has_many :articles, FrankBlog.Article

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password])
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> update_change(:encrypted_password, &salt_password/1)
  end

  defp salt_password(password) do
    hash = Bcrypt.hash_pwd_salt(password)
    hash
  end
end
