defmodule RallyHookProxy.RallyKey do
  use RallyHookProxy.Web, :model

  alias RallyHookProxy.Repo
  import Ecto.Query

  schema "rally_keys" do
    field :rally_token, :string
    belongs_to :user, RallyHookProxy.User

    timestamps
  end

  @required_fields ~w(rally_token)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def find_by_username(username) do
    Repo.all from r in __MODULE__,
      join: u  in assoc(r, :user),
      where: u.email == ^username
  end

end
