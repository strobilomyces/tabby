defmodule TabbyWeb.ArtistControllerTest do
  use TabbyWeb.ConnCase

  import Tabby.ArtistsFixtures

  @create_attrs %{name: "some name", slug: "some slug"}
  @update_attrs %{name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{name: nil, slug: nil}

  describe "index" do
    test "lists all artists", %{conn: conn} do
      conn = get(conn, ~p"/artists")
      assert html_response(conn, 200) =~ "Listing Artists"
    end
  end

  describe "new artist" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/artists/new")
      assert html_response(conn, 200) =~ "New Artist"
    end
  end

  describe "create artist" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/artists", artist: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/artists/#{id}"

      conn = get(conn, ~p"/artists/#{id}")
      assert html_response(conn, 200) =~ "Artist #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/artists", artist: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Artist"
    end
  end

  describe "edit artist" do
    setup [:create_artist]

    test "renders form for editing chosen artist", %{conn: conn, artist: artist} do
      conn = get(conn, ~p"/artists/#{artist}/edit")
      assert html_response(conn, 200) =~ "Edit Artist"
    end
  end

  describe "update artist" do
    setup [:create_artist]

    test "redirects when data is valid", %{conn: conn, artist: artist} do
      conn = put(conn, ~p"/artists/#{artist}", artist: @update_attrs)
      assert redirected_to(conn) == ~p"/artists/#{artist}"

      conn = get(conn, ~p"/artists/#{artist}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, artist: artist} do
      conn = put(conn, ~p"/artists/#{artist}", artist: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Artist"
    end
  end

  describe "delete artist" do
    setup [:create_artist]

    test "deletes chosen artist", %{conn: conn, artist: artist} do
      conn = delete(conn, ~p"/artists/#{artist}")
      assert redirected_to(conn) == ~p"/artists"

      assert_error_sent 404, fn ->
        get(conn, ~p"/artists/#{artist}")
      end
    end
  end

  defp create_artist(_) do
    artist = artist_fixture()

    %{artist: artist}
  end
end
