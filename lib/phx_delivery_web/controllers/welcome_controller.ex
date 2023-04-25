defmodule PhxDeliveryWeb.WelcomeController do
  use PhxDeliveryWeb, :controller

  def index(conn, params) do


    conn
    |> put_status(:ok)
    |> text("Welcome to the jungle")
  end
end
