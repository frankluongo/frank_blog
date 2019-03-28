defmodule FrankBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :encrypted_password, :string
      add :article_id, references(:articles, on_delete: :delete_all)

      timestamps()
    end

    alter table(:articles) do
      add :user_id, references(:users)
      add :slug, :string
    end

    create unique_index(:users, [:username])
    create index(:articles, [:title])
  end
end
