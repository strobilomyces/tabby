defmodule Tabby.AlbumsTest do
  use Tabby.DataCase

  alias Tabby.Albums

  describe "albums" do
    alias Tabby.Albums.Album

    import Tabby.AlbumsFixtures

    @invalid_attrs %{name: nil, slug: nil, year_input: nil}

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      expected_album = %{album | year_input: nil, artist_ids: nil}

      assert Albums.list_albums() == [expected_album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      expected_album = %{album | year_input: nil, artist_ids: nil}

      assert Albums.get_album!(album.id) == expected_album
    end

    test "create_album/1 with valid data creates a album" do
      artist = Tabby.ArtistsFixtures.artist_fixture()

      valid_attrs = %{
        name: "some name",
        slug: "some slug",
        year_input: 2026,
        artist_ids: [artist.id]
      }

      assert {:ok, %Album{} = album} = Albums.create_album(valid_attrs)
      assert album.name == "some name"
      assert album.slug == "some slug"
      assert album.release_year.year == 2026
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Albums.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()

      update_attrs = %{
        name: "some updated name",
        slug: "some updated slug",
        year_input: 2025
      }

      assert {:ok, %Album{} = album} = Albums.update_album(album, update_attrs)
      assert album.name == "some updated name"
      assert album.slug == "some updated slug"
      assert album.release_year.year == 2025
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      expected_album = %{album | year_input: nil, artist_ids: nil}

      assert {:error, %Ecto.Changeset{}} = Albums.update_album(expected_album, @invalid_attrs)
      assert expected_album == Albums.get_album!(expected_album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Albums.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Albums.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Albums.change_album(album)
    end
  end
end
