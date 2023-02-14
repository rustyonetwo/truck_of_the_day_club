defmodule TruckOfTheDayClub.Trucks.UpdateTrucks do
  @moduledoc """
  Quick and dirty udpate function to grab the current list from the api
  This should be modified to use an adapter for local testing
  This is intended to be run by a daily or weekly worker to keep the db up to date
  """

  alias TruckOfTheDayClub.Trucks

  @soda_api_endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  def ingest_current_trucks() do
    for truck <- get_current_trucks() do
      Trucks.create_or_update_truck(truck)
    end
  end

  defp get_current_trucks() do
    case HTTPoison.get(@soda_api_endpoint) do
      {:ok, %HTTPoison.Response{body: body}} -> Jason.decode!(body)
      {:error, reason} -> reason
    end
  end
end
