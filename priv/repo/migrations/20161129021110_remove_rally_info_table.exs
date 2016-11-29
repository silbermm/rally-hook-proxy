defmodule RallyHookProxy.Repo.Migrations.RemoveRallyInfoTable do
  use Ecto.Migration

  def change do
    drop table(:rally_info)
  end
end
