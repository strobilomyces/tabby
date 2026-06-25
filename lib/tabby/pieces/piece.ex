defmodule Tabby.Pieces.Piece do
  use Ecto.Schema
  import Ecto.Changeset

  @submission_type_list %{
    Chords: "Chords",
    "Guitar Tab": "Guitar Tab",
    "Bass Tab": "Bass Tab"
  }

  def submission_types, do: Enum.to_list(@submission_type_list)

  @instrument_list %{
    Guitar: "Guitar",
    "12-String Guitar": "12-String Guitar",
    Bass: "Bass"
  }

  def instruments, do: Enum.to_list(@instrument_list)

  @tuning_list %{
    Standard: "EADGBE",
    "Dropped D": "DADGBE",
    "Open D": "DADF#AD",
    "Open G": "DGDGBD",
    Celtic: "DADGAD"
  }

  def tunings, do: Enum.to_list(@tuning_list)

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
