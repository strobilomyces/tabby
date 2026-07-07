defmodule Tabby.PiecesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Pieces` context.
  """

  def unique_name, do: "some name #{System.unique_integer([:positive])}"
  def artist_id, do: Tabby.ArtistsFixtures.artist_fixture().id
  def album_id, do: Tabby.AlbumsFixtures.album_fixture().id

  @doc """
  Generate a piece.
  """
  def piece_fixture(attrs \\ %{}) do
    {:ok, piece} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        instrument: "some instrument",
        name: unique_name(),
        tuning: "some tuning",
        type: "some type",
        artist_ids: [artist_id()],
        album_ids: [album_id()]
      })
      |> Tabby.Pieces.create_piece()

    piece
  end
end
