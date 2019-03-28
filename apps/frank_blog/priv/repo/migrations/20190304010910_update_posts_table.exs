defmodule FrankBlog.Repo.Migrations.UpdatePostsTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :body, :text
      add :published_at, :naive_datetime

      timestamps()
    end

  end

end
