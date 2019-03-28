defmodule FrankBlog.Repo.Migrations.RemovePublishedAtField do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      remove :published_at
    end
  end
end
