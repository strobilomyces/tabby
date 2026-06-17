defmodule Tabby.Artists.Artist do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :slug, :string

    many_to_many :albums, Tabby.Albums.Album, join_through: "artists_albums"
    many_to_many :pieces, Tabby.Pieces.Piece, join_through: "artists_pieces"

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
