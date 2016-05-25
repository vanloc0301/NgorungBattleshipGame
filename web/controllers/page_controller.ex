defmodule NgorungBattleshipGame.PageController do
  use NgorungBattleshipGame.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
