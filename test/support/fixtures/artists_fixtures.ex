defmodule Tabby.ArtistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Artists` context.
  """

  def unique_name, do: "some name #{System.unique_integer([:positive])}"

  @doc """
  Generate a artist.
  """
  def artist_fixture(attrs \\ %{}) do
    {:ok, artist} =
      attrs
      |> Enum.into(%{
        name: unique_name()
      })
      |> Tabby.Artists.create_artist()

    artist
  end
end
