defmodule RallyHookProxy.Factory do
  use ExMachina.Ecto, repo: RallyHookProxy.Repo

  alias RallyHookProxy.User

  def factory(:user) do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
    }
  end

  def with_rally_key(user) do
    %{user | rally_token: sequence(:rally_token, &"some_random_key#{&1}")}
  end
end
