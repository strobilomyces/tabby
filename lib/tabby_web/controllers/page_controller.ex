defmodule TabbyWeb.PageController do
  use TabbyWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
