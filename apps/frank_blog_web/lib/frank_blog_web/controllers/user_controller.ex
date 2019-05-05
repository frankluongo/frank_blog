defmodule FrankBlogWeb.UserController do
  use FrankBlogWeb, :controller

  alias FrankBlog.User
  alias FrankBlog.UserQueries

  import Ecto.Changeset

  def create(conn, %{"user" => user_params}) do
    if UserQueries.verify_user(user_params) do
      {:ok, user} = UserQueries.verify_user(user_params)
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Logged in successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
    else
      case UserQueries.create_user(user_params) do
      {:ok, user} ->
          conn
          |> put_session(:current_user_id, user.id)
          |> put_flash(:info, "Signed up successfully.")
          |> redirect(to: Routes.page_path(conn, :index))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def index(conn, _params) do
    id = conn.private.plug_session["current_user_id"]
    if id do
      user = UserQueries.get_user(id)
      render(conn, "index.html", user: user)
    else
      redirect(conn, to: Routes.user_path(conn, :new))
    end
  end

  def new(conn, _params) do
    changeset = UserQueries.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end
end
