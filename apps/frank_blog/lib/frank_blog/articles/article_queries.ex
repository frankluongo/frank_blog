defmodule FrankBlog.ArticleQueries do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Bcrypt
  alias FrankBlog.Article
  alias FrankBlog.Repo

  def add_article_details(conn, attrs) do
    user_id = conn.private.plug_session["current_user_id"]
    slug = create_slug(attrs["article"])

    %{"user_id" => user_id, "slug" => slug}
  end

  def changeset(%Article{} = article, attrs) do
    IO.inspect("-----------------------------------")
    IO.inspect(article)
    IO.inspect("-----------------------------------")
    article
    |> cast(attrs, [:title, :body])
    |> unique_constraint(:title)
    |> validate_required([:title, :body])
  end

  def change_article(%Article{} = article) do
    changeset(article, %{})
  end

  def create_article(attrs \\ %{}) do
    IO.inspect(attrs)
    # full_article = Map.merge(attrs["article"], add_article_details(conn, attrs))
    # attrs = Map.put(attrs, "article", full_article)
    # IO.inspect(attrs)

    %Article{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def create_slug(%{ "title" => title }) do
    String.trim(title)
    |> String.downcase
    |> String.replace(" ", "-")
  end


  def get_by_username(username) when is_nil(username), do: nil
  def get_by_username(username) do
    user = Repo.get_by(User, username: username)
    Repo.get_by(Article, user_id: user.id)
  end

  def list_articles do
    Repo.all(Article)
  end

  def get_article!(id), do:  Repo.get(Article, id) |> Repo.preload(:user_id)
  def get_article(id), do: Repo.get(Article, id) |> Repo.preload(:user_id)

  def update_article(%Article{} = article, attrs) do
    article
    |> changeset(attrs)
    |> Repo.update()
  end

  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end
end
