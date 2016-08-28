defmodule RallyHookProxy.Repo.Migrations.AddRallyTokenToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :rally_token, :string
    end
  end
end
