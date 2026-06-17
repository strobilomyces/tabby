defmodule TabbyWeb.PieceHTML do
  use TabbyWeb, :html

  embed_templates "piece_html/*"

  @doc """
  Renders a piece form.

  The form is defined in the template at
  piece_html/piece_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def piece_form(assigns)
end
