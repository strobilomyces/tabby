defmodule Tabby.Repo.Migrations.CreateArtistsPieces do
  use Ecto.Migration

  def change do
    create table(:artists_pieces) do
      add :artist_id, references(:artists, on_delete: :delete_all)
      add :piece_id, references(:pieces, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:artists_pieces, [:artist_id, :piece_id])
  end
end
