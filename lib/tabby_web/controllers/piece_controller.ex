defmodule TabbyWeb.PieceController do
  use TabbyWeb, :controller

  alias Tabby.Pieces
  alias Tabby.Pieces.Piece

  def index(conn, _params) do
    pieces = Pieces.list_pieces()
    render(conn, :index, pieces: pieces)
  end

  def new(conn, _params) do
    changeset = Pieces.change_piece(%Piece{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"piece" => piece_params}) do
    case Pieces.create_piece(piece_params) do
      {:ok, piece} ->
        conn
        |> put_flash(:info, "Piece created successfully.")
        |> redirect(to: ~p"/pieces/#{piece}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    piece = Pieces.get_piece!(id)
    render(conn, :show, piece: piece)
  end

  def edit(conn, %{"id" => id}) do
    piece = Pieces.get_piece!(id)
    changeset = Pieces.change_piece(piece)
    render(conn, :edit, piece: piece, changeset: changeset)
  end

  def update(conn, %{"id" => id, "piece" => piece_params}) do
    piece = Pieces.get_piece!(id)

    case Pieces.update_piece(piece, piece_params) do
      {:ok, piece} ->
        conn
        |> put_flash(:info, "Piece updated successfully.")
        |> redirect(to: ~p"/pieces/#{piece}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, piece: piece, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    piece = Pieces.get_piece!(id)
    {:ok, _piece} = Pieces.delete_piece(piece)

    conn
    |> put_flash(:info, "Piece deleted successfully.")
    |> redirect(to: ~p"/pieces")
  end
end
