defmodule Tabby.Artists.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  def artist_list, do: Tabby.Artists.list_artists() |> Enum.map(&{&1.name, &1.id})

  schema "artists" do
    field :name, :string
    field :slug, :string

    many_to_many :albums, Tabby.Albums.Album,
      join_through: Tabby.ArtistsAlbums.ArtistAlbum,
      on_replace: :delete

    many_to_many :pieces, Tabby.Pieces.Piece,
      join_through: Tabby.ArtistsPieces.ArtistPiece,
      on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end
end
