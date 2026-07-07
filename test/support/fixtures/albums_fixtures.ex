defmodule Tabby.AlbumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Albums` context.
  """

  def unique_name, do: "some name #{System.unique_integer([:positive])}"

  def artist_id, do: Tabby.ArtistsFixtures.artist_fixture().id

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: unique_name(),
        year_input: 2026,
        artist_ids: [artist_id()]
      })
      |> Tabby.Albums.create_album()

    album
  end
end
