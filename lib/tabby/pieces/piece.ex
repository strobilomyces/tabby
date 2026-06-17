defmodule Tabby.Pieces.Piece do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pieces" do
    field :name, :string
    field :slug, :string
    field :type, :string
    field :instrument, :string
    field :tuning, :string
    field :contents, :string

    belongs_to :user, Tabby.Accounts.User

    many_to_many :artists, Tabby.Artists.Artist, join_through: "artists_pieces"
    many_to_many :albums, Tabby.Albums.Album, join_through: "albums_pieces"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(piece, attrs) do
    piece
    |> cast(attrs, [:name, :slug, :type, :instrument, :tuning, :contents])
    |> validate_required([:name, :slug, :type, :instrument, :tuning, :contents])
    |> unique_constraint(:slug)
  end
end
