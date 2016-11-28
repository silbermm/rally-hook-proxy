defmodule RallyHookProxy.Repo.Migrations.AddRallyInfoTable do
  use Ecto.Migration

  def change do
    create table(:rally_info) do
      add :rally_token, :string
      add :user_id, references(:users)
      timestamps
    end
  end
end
