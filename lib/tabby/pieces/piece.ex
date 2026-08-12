defmodule Tabby.Pieces.Piece do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  def submission_types,
    do: [
      "": "",
      Chords: "Chords",
      "Guitar Tab": "Guitar Tab",
      "Bass Tab": "Bass Tab"
    ]

  def instruments,
    do: [
      "": "",
      Guitar: "Guitar",
      "12-String Guitar": "12-String Guitar",
      Bass: "Bass"
    ]

  def tunings,
    do: [
      "": "",
      Standard: "EADGBE",
      "Dropped D": "DADGBE",
      "Open D": "DADF#AD",
      "Open G": "DGDGBD",
      Celtic: "DADGAD"
    ]

  def capo_options,
    do: [
      "": "",
      "1st": "1",
      "2nd": "2",
      "3rd": "3",
      "4th": "4",
      "5th": "5",
      "6th": "6",
      "7th": "7",
      "8th": "8",
      "9th": "9",
      "10th": "10",
      "11th": "11",
      "12th": "12"
    ]

  schema "pieces" do
    field :name, :string
    field :slug, :string
    field :type, :string
    field :instrument, :string
    field :tuning, :string
    field :capo, :string
    field :contents, :string

    belongs_to :user, Tabby.Accounts.User

    many_to_many :artists, Tabby.Artists.Artist,
      join_through: Tabby.ArtistsPieces.ArtistPiece,
      on_replace: :delete

    field :artist_ids, {:array, :id}, virtual: true

    many_to_many :albums, Tabby.Albums.Album,
      join_through: Tabby.AlbumsPieces.AlbumPiece,
      on_replace: :delete

    field :album_ids, {:array, :id}, virtual: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(piece, attrs) do
    piece
    |> cast(attrs, [:name, :type, :instrument, :tuning, :contents, :capo, :artist_ids])
    |> validate_required([:name, :type, :instrument, :tuning, :contents, :artist_ids])
    |> generate_slug()
    |> unique_constraint(:slug)
    |> update_artists()
  end

  def update_artists(changeset) do
    case get_change(changeset, :artist_ids) do
      nil ->
        changeset

      artist_ids ->
        query = from a in Tabby.Artists.Artist, where: a.id in ^artist_ids
        artists = Tabby.Repo.all(query)

        put_assoc(changeset, :artists, artists)
    end
  end

  def update_albums(changeset) do
    case get_change(changeset, :album_ids) do
      nil ->
        changeset

      album_ids ->
        query = from a in Tabby.Albums.Album, where: a.id in ^album_ids
        albums = Tabby.Repo.all(query)

        put_assoc(changeset, :albums, albums)
    end
  end

  defp generate_slug(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, name} ->
        slug = Slugy.slugify(name)
        put_change(changeset, :slug, slug)

      :error ->
        changeset
    end
  end
end
