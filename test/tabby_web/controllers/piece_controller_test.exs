defmodule TabbyWeb.PieceControllerTest do
  use TabbyWeb.ConnCase

  import Tabby.PiecesFixtures

  @create_attrs %{
    name: "some name",
    type: "some type",
    slug: "some slug",
    instrument: "some instrument",
    tuning: "some tuning",
    contents: "some contents"
  }
  @update_attrs %{
    name: "some updated name",
    type: "some updated type",
    slug: "some updated slug",
    instrument: "some updated instrument",
    tuning: "some updated tuning",
    contents: "some updated contents"
  }
  @invalid_attrs %{name: nil, type: nil, slug: nil, instrument: nil, tuning: nil, contents: nil}

  describe "index" do
    test "lists all pieces", %{conn: conn} do
      conn = get(conn, ~p"/pieces")
      assert html_response(conn, 200) =~ "Listing Pieces"
    end
  end

  describe "new piece" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/pieces/new")
      assert html_response(conn, 200) =~ "New Piece"
    end
  end

  describe "create piece" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/pieces", piece: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/pieces/#{id}"

      conn = get(conn, ~p"/pieces/#{id}")
      assert html_response(conn, 200) =~ "Piece #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/pieces", piece: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Piece"
    end
  end

  describe "edit piece" do
    setup [:create_piece]

    test "renders form for editing chosen piece", %{conn: conn, piece: piece} do
      conn = get(conn, ~p"/pieces/#{piece}/edit")
      assert html_response(conn, 200) =~ "Edit Piece"
    end
  end

  describe "update piece" do
    setup [:create_piece]

    test "redirects when data is valid", %{conn: conn, piece: piece} do
      conn = put(conn, ~p"/pieces/#{piece}", piece: @update_attrs)
      assert redirected_to(conn) == ~p"/pieces/#{piece}"

      conn = get(conn, ~p"/pieces/#{piece}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, piece: piece} do
      conn = put(conn, ~p"/pieces/#{piece}", piece: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Piece"
    end
  end

  describe "delete piece" do
    setup [:create_piece]

    test "deletes chosen piece", %{conn: conn, piece: piece} do
      conn = delete(conn, ~p"/pieces/#{piece}")
      assert redirected_to(conn) == ~p"/pieces"

      assert_error_sent 404, fn ->
        get(conn, ~p"/pieces/#{piece}")
      end
    end
  end

  defp create_piece(_) do
    piece = piece_fixture()

    %{piece: piece}
  end
end
