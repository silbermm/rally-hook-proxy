defmodule RallyHookProxy.Repo.Migrations.RemoveRallyKeysTable do
  use Ecto.Migration

  def change do
    drop table(:rally_keys)
  end
end
