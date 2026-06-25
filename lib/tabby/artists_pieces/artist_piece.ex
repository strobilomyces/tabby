defmodule Tabby.ArtistsPieces.ArtistPiece do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists_pieces" do
    belongs_to :artist, Tabby.Artists.Artist
    belongs_to :piece, Tabby.Pieces.Piece

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(artist_piece, attrs) do
    artist_piece
    |> cast(attrs, [:artist_id, :piece_id])
    |> validate_required([:artist_id, :piece_id])
    |> unique_constraint([:artist_id, :piece_id])
  end
end
