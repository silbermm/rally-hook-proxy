defmodule RallyHookProxy.Factory do
  use ExMachina.Ecto, repo: RallyHookProxy.Repo

  alias RallyHookProxy.User

  def factory(:user) do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com")
    }
  end

  def factory(:user_with_good_token) do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      rally_token: "rally_token_with_response"
    }
  end

  def factory(:user_with_error_token) do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      rally_token: "rally_token_with_error"
    }
  end

  def with_rally_key(user) do
    %{user | rally_token: sequence(:rally_token, &"some_random_key#{&1}")}
  end
end
