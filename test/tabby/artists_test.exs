defmodule Tabby.ArtistsTest do
  use Tabby.DataCase

  alias Tabby.Artists

  describe "artists" do
    alias Tabby.Artists.Artist

    import Tabby.ArtistsFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_artists/0 returns all artists" do
      artist = artist_fixture()
      assert Artists.list_artists() == [artist]
    end

    test "get_artist!/1 returns the artist with given id" do
      artist = artist_fixture()
      assert Artists.get_artist!(artist.id) == artist
    end

    test "create_artist/1 with valid data creates a artist" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %Artist{} = artist} = Artists.create_artist(valid_attrs)
      assert artist.name == "some name"
      assert artist.slug == "some slug"
    end

    test "create_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Artists.create_artist(@invalid_attrs)
    end

    test "update_artist/2 with valid data updates the artist" do
      artist = artist_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Artist{} = artist} = Artists.update_artist(artist, update_attrs)
      assert artist.name == "some updated name"
      assert artist.slug == "some updated slug"
    end

    test "update_artist/2 with invalid data returns error changeset" do
      artist = artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Artists.update_artist(artist, @invalid_attrs)
      assert artist == Artists.get_artist!(artist.id)
    end

    test "delete_artist/1 deletes the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{}} = Artists.delete_artist(artist)
      assert_raise Ecto.NoResultsError, fn -> Artists.get_artist!(artist.id) end
    end

    test "change_artist/1 returns a artist changeset" do
      artist = artist_fixture()
      assert %Ecto.Changeset{} = Artists.change_artist(artist)
    end
  end
end
