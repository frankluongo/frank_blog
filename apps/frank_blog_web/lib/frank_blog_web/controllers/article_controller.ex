defmodule FrankBlogWeb.ArticleController do
  use FrankBlogWeb, :controller

  alias FrankBlog.Article
  alias FrankBlog.ArticleQueries

  import Ecto.Changeset

  def create(conn, article_params) do
    case ArticleQueries.create_article(article_params) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article Created!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    id = conn.private.plug_session["current_user_id"]
    if id do
      changeset = ArticleQueries.change_article(%Article{})
      render(conn, "new.html", changeset: changeset)
    else
      redirect(conn, to: Routes.user_path(conn, :new))
    end
  end
end
