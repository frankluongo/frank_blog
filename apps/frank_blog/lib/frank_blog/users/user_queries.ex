defmodule FrankBlog.UserQueries do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Bcrypt
  alias FrankBlog.User
  alias FrankBlog.Repo

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


  def get_by_username(username) when is_nil(username), do: nil
  def get_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do:  Repo.get(User, id) |> Repo.preload(:articles)
  def get_user(id), do: Repo.get(User, id) |> Repo.preload(:articles)

  def create_user(attrs \\ %{}) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    changeset(user, %{})
  end

  def verify_user(%{"encrypted_password" => encrypted_password, "username" => username} \\ %{}) do
    valid_user = Repo.get_by(User, username: username)
    if valid_user do
      valid_password = Bcrypt.verify_pass(encrypted_password, valid_user.encrypted_password)
        if valid_user && valid_password, do: {:ok, valid_user}
    else
      false
    end
  end
  def verify_user(_), do: false
end
