defmodule PhxDelivery.Users.Create do
  alias PhxDelivery.Repo
  alias PhxDelivery.User

  def execute(parmas) do
    parmas
    |> User.changeset()
    |> Repo.insert()
  end
end
