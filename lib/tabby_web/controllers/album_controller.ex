defmodule TabbyWeb.AlbumController do
  use TabbyWeb, :controller

  alias Tabby.Albums
  alias Tabby.Albums.Album

  def index(conn, _params) do
    albums = Albums.list_albums()
    render(conn, :index, albums: albums)
  end

  def new(conn, _params) do
    changeset = Albums.change_album(%Album{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"album" => album_params}) do
    case Albums.create_album(album_params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album created successfully.")
        |> redirect(to: ~p"/albums/#{album}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    album = Albums.get_album!(id)
    render(conn, :show, album: album)
  end

  def edit(conn, %{"id" => id}) do
    album = Albums.get_album!(id)
    changeset = Albums.change_album(album)
    render(conn, :edit, album: album, changeset: changeset)
  end

  def update(conn, %{"id" => id, "album" => album_params}) do
    album = Albums.get_album!(id)

    case Albums.update_album(album, album_params) do
      {:ok, album} ->
        conn
        |> put_flash(:info, "Album updated successfully.")
        |> redirect(to: ~p"/albums/#{album}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, album: album, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Albums.get_album!(id)
    {:ok, _album} = Albums.delete_album(album)

    conn
    |> put_flash(:info, "Album deleted successfully.")
    |> redirect(to: ~p"/albums")
  end
end
