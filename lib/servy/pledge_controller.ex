defmodule Servy.PledgeController do
  def create(conv, %{"name" => name, "amount" => amount}) do
    # Sends the pledge to the external service and caches it
    Servy.PledgeServer.create_pledge(name, String.to_integer(amount))

    %{ conv | status: 201, resp_body: "#{name} pledged #{amount}!"}
  end

  @spec index(%{resp_body: any, status: any}) :: %{resp_body: binary, status: 200}
  def index(conv) do
    # Gets the recent pledges from the cache
    pledges = Servy.PledgeServer.recent_pledges()

    %{ conv | status: 200, resp_body: (inspect pledges)}
  end
end
