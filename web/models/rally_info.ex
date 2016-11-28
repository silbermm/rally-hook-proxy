defmodule RallyHookProxy.RallyInfo do
  use RallyHookProxy.Web, :model

  alias RallyHookProxy.Repo
  alias RallyHookProxy.User

  import Ecto.Query

  schema "rally_info" do
    field :rally_token, :string
    belongs_to :user, User

    timestamps
  end

  @required_fields ~w(user)
  @optional_fields ~w(rally_token)

  def changeset(model, params \\ %{}) do
    model
    #|> cast(params, [:user, :rally_token])
    |> unique_constraint(:user)
  end

  def find_by_username(username) do
    Repo.all from r in __MODULE__,
      join: u  in assoc(r, :user),
      where: u.email == ^username
  end
end
