defmodule Tabby.Albums.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :name, :string
    field :slug, :string
    field :release_year, :date

    field :year_input, :integer, virtual: true

    many_to_many :artists, Tabby.Artists.Artist, join_through: "artists_albums"
    many_to_many :pieces, Tabby.Pieces.Piece, join_through: "albums_pieces"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name, :slug, :year_input])
    |> validate_required([:name, :slug, :year_input])
    |> unique_constraint(:slug)
    |> handle_year_input()
  end


  defp handle_year_input(changeset) do
    case Ecto.Changeset.get_change(changeset, :year_input) do
      nil -> 
        changeset # Do nothing if the year was not altered or provided
      
      year ->
        # Construct an ISO 8601 compliant string for Jan 1st
        {:ok, date_struct} = Date.new(year, 1, 1) 
      
        # Inject the fully constructed date string into your actual database column
        Ecto.Changeset.put_change(changeset, :release_year, date_struct)
    end
  end
end
