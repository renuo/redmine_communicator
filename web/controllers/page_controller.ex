defmodule RedmineCommunicator.PageController do
  use RedmineCommunicator.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
