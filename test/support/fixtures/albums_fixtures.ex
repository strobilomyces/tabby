defmodule Tabby.AlbumsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Albums` context.
  """

  @doc """
  Generate a unique album slug.
  """
  def unique_album_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        name: "some name",
        year_input: 2026,
        slug: unique_album_slug()
      })
      |> Tabby.Albums.create_album()

    album
  end
end
