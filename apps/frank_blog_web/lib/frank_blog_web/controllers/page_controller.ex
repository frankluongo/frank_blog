defmodule FrankBlogWeb.PageController do
  use FrankBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
