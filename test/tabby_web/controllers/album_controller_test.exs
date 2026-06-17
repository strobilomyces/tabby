defmodule TabbyWeb.AlbumControllerTest do
  use TabbyWeb.ConnCase

  import Tabby.AlbumsFixtures

  @create_attrs %{name: "some name", slug: "some slug", year_input: 2026}
  @update_attrs %{
    name: "some updated name",
    slug: "some updated slug",
    year_input: 2024
  }
  @invalid_attrs %{name: nil, slug: nil, year_input: nil}

  describe "index" do
    test "lists all albums", %{conn: conn} do
      conn = get(conn, ~p"/albums")
      assert html_response(conn, 200) =~ "Listing Albums"
    end
  end

  describe "new album" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/albums/new")
      assert html_response(conn, 200) =~ "New Album"
    end
  end

  describe "create album" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/albums", album: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/albums/#{id}"

      conn = get(conn, ~p"/albums/#{id}")
      assert html_response(conn, 200) =~ "Album #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/albums", album: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Album"
    end
  end

  describe "edit album" do
    setup [:create_album]

    test "renders form for editing chosen album", %{conn: conn, album: album} do
      conn = get(conn, ~p"/albums/#{album}/edit")
      assert html_response(conn, 200) =~ "Edit Album"
    end
  end

  describe "update album" do
    setup [:create_album]

    test "redirects when data is valid", %{conn: conn, album: album} do
      conn = put(conn, ~p"/albums/#{album}", album: @update_attrs)
      assert redirected_to(conn) == ~p"/albums/#{album}"

      conn = get(conn, ~p"/albums/#{album}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, album: album} do
      conn = put(conn, ~p"/albums/#{album}", album: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Album"
    end
  end

  describe "delete album" do
    setup [:create_album]

    test "deletes chosen album", %{conn: conn, album: album} do
      conn = delete(conn, ~p"/albums/#{album}")
      assert redirected_to(conn) == ~p"/albums"

      assert_error_sent 404, fn ->
        get(conn, ~p"/albums/#{album}")
      end
    end
  end

  defp create_album(_) do
    album = album_fixture()

    %{album: album}
  end
end
