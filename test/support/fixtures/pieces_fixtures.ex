defmodule Tabby.PiecesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tabby.Pieces` context.
  """

  @doc """
  Generate a unique piece slug.
  """
  def unique_piece_slug, do: "some slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a piece.
  """
  def piece_fixture(attrs \\ %{}) do
    {:ok, piece} =
      attrs
      |> Enum.into(%{
        contents: "some contents",
        instrument: "some instrument",
        name: "some name",
        slug: unique_piece_slug(),
        tuning: "some tuning",
        type: "some type"
      })
      |> Tabby.Pieces.create_piece()

    piece
  end
end
