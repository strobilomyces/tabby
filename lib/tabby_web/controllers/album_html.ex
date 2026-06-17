defmodule TabbyWeb.AlbumHTML do
  use TabbyWeb, :html

  embed_templates "album_html/*"

  @doc """
  Renders a album form.

  The form is defined in the template at
  album_html/album_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def album_form(assigns)
end
