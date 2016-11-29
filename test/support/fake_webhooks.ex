defmodule RallyHookProxy.FakeWebhooks do
  alias Rallex.WebhookResponse

  def list("rally_token_with_response" = token) do
    {:ok, 
      %{"Results" => [
        %WebhookResponse{Name: "fakeName1" },
        %WebhookResponse{Name: "fakeName2" }
      ]}
    }
  end

  def list("rally_token_with_error" = token) do
    {:error, nil}
  end

  def list(token) do
    {:ok, nil}
  end
end
