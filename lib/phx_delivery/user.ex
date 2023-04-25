defmodule PhxDelivery.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [
    :address,
    :age,
    :cep,
    :cpf,
    :email,
    :password,
    :name
  ]
  schema "users" do
    field(:address, :string)
    field(:age, :integer)
    field(:cep, :string)
    field(:cpf, :string)
    field(:email, :string)
    field(:name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password_length, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:password_length, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 16)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end
end
