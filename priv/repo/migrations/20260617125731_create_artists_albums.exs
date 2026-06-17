defmodule Tabby.Repo.Migrations.CreateArtistsAlbums do
  use Ecto.Migration

  def change do
    create table(:artists_albums) do
      add :artist_id, references(:artists, on_delete: :delete_all)
      add :album_id, references(:albums, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:artists_albums, [:artist_id, :album_id])
  end
end
