defmodule TruckOfTheDayClub.Trucks do
  @moduledoc """
  Context for food trucks
  This should be continued to fine tune the upsert
  """
  alias TruckOfTheDayClub.Repo
  alias TruckOfTheDayClub.Trucks.Truck

  import Ecto.Query, only: [from: 2]

  def list_trucks() do
    Repo.all(Truck)
  end

  def list_active_trucks() do
    query =
      from t in Truck,
        where: t.status == "APPROVED"

    Repo.all(query)
  end

  def create_or_update_truck(attrs) do
    %Truck{}
    |> Truck.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
  end

  def select_random_truck(trucks) do
    Enum.random(trucks)
  end

  def get_truck_of_the_day() do
    list_active_trucks()
    |> select_random_truck()
  end
end
