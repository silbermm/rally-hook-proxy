defmodule RallyHookProxy.Repo.Migrations.CreateRallyKey do
  use Ecto.Migration

  def change do
    create table(:rally_keys) do
      add :rally_token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps
    end
    create index(:rally_keys, [:user_id])

  end
end
