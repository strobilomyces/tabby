defmodule Tabby.ArtistsAlbums.ArtistAlbum do
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists_albums" do
    belongs_to :artist, Tabby.Artists.Artist
    belongs_to :album, Tabby.Albums.Album

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(artist_album, attrs) do
    artist_album
    |> cast(attrs, [:artist_id, :album_id])
    |> validate_required([:artist_id, :album_id])
    |> unique_constraint([:artist_id, :album_id])
  end
end
