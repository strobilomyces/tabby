defmodule Tabby.PiecesTest do
  use Tabby.DataCase

  alias Tabby.Pieces

  describe "pieces" do
    alias Tabby.Pieces.Piece

    import Tabby.PiecesFixtures

    @invalid_attrs %{name: nil, type: nil, slug: nil, instrument: nil, tuning: nil, contents: nil}

    test "list_pieces/0 returns all pieces" do
      piece = piece_fixture()
      assert Pieces.list_pieces() == [piece]
    end

    test "get_piece!/1 returns the piece with given id" do
      piece = piece_fixture()
      assert Pieces.get_piece!(piece.id) == piece
    end

    test "create_piece/1 with valid data creates a piece" do
      valid_attrs = %{
        name: "some name",
        type: "some type",
        slug: "some slug",
        instrument: "some instrument",
        tuning: "some tuning",
        contents: "some contents"
      }

      assert {:ok, %Piece{} = piece} = Pieces.create_piece(valid_attrs)
      assert piece.name == "some name"
      assert piece.type == "some type"
      assert piece.slug == "some slug"
      assert piece.instrument == "some instrument"
      assert piece.tuning == "some tuning"
      assert piece.contents == "some contents"
    end

    test "create_piece/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pieces.create_piece(@invalid_attrs)
    end

    test "update_piece/2 with valid data updates the piece" do
      piece = piece_fixture()

      update_attrs = %{
        name: "some updated name",
        type: "some updated type",
        slug: "some updated slug",
        instrument: "some updated instrument",
        tuning: "some updated tuning",
        contents: "some updated contents"
      }

      assert {:ok, %Piece{} = piece} = Pieces.update_piece(piece, update_attrs)
      assert piece.name == "some updated name"
      assert piece.type == "some updated type"
      assert piece.slug == "some updated slug"
      assert piece.instrument == "some updated instrument"
      assert piece.tuning == "some updated tuning"
      assert piece.contents == "some updated contents"
    end

    test "update_piece/2 with invalid data returns error changeset" do
      piece = piece_fixture()
      assert {:error, %Ecto.Changeset{}} = Pieces.update_piece(piece, @invalid_attrs)
      assert piece == Pieces.get_piece!(piece.id)
    end

    test "delete_piece/1 deletes the piece" do
      piece = piece_fixture()
      assert {:ok, %Piece{}} = Pieces.delete_piece(piece)
      assert_raise Ecto.NoResultsError, fn -> Pieces.get_piece!(piece.id) end
    end

    test "change_piece/1 returns a piece changeset" do
      piece = piece_fixture()
      assert %Ecto.Changeset{} = Pieces.change_piece(piece)
    end
  end
end
