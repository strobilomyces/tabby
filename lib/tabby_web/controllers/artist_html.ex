defmodule TabbyWeb.ArtistHTML do
  use TabbyWeb, :html

  embed_templates "artist_html/*"

  @doc """
  Renders a artist form.

  The form is defined in the template at
  artist_html/artist_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def artist_form(assigns)
end
