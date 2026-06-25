defmodule Tabby.AlbumsPieces.AlbumPiece do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums_pieces" do
    belongs_to :album, Tabby.Albums.Album
    belongs_to :piece, Tabby.Pieces.Piece

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(album_piece, attrs) do
    album_piece
    |> cast(attrs, [:album_id, :piece_id])
    |> validate_required([:album_id, :piece_id])
    |> unique_constraint([:album_id, :piece_id])
  end
end
