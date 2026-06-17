defmodule Tabby.ArtistsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Artists` context.
  """

  @doc """
  Generate a unique artist slug.
  """
  def unique_artist_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a artist.
  """
  def artist_fixture(attrs \\ %{}) do
    {:ok, artist} =
      attrs
      |> Enum.into(%{
        name: "some name",
        slug: unique_artist_slug()
      })
      |> Tabby.Artists.create_artist()

    artist
  end
end
