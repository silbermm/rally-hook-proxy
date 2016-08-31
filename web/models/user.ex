defmodule RallyHookProxy.User do
  use RallyHookProxy.Web, :model

  alias RallyHookProxy.Repo
  import Ecto.Query, only: [from: 2]

  schema "users" do
    field :email, :string
    field :rally_token, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w(rally_token)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
  end

  def find_by_username(username) do
    Repo.get_by(__MODULE__, email: username)
  end
end
