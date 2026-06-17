defmodule Tabby.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :slug, :string
      add :release_year, :date

      timestamps(type: :utc_datetime)
    end

    create unique_index(:albums, [:slug])
  end
end
