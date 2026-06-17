defmodule Tabby.Repo.Migrations.CreateAlbumsPieces do
  use Ecto.Migration

  def change do
    create table(:albums_pieces) do
      add :album_id, references(:albums, on_delete: :delete_all)
      add :piece_id, references(:pieces, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:albums_pieces, [:album_id, :piece_id])
  end
end
