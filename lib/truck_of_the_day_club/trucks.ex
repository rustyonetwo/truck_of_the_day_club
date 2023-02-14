defmodule TruckOfTheDayClub.Trucks do
  @moduledoc """
  Context for food trucks
  """
  alias TruckOfTheDayClub.Repo
  alias TruckOfTheDayClub.Trucks.Truck

  import Ecto.Query, only: [from: 2]

  @spec list_trucks() :: list(Truck)
  def list_trucks() do
    Repo.all(Truck)
  end

  @spec list_active_trucks() :: list(Truck)
  def list_active_trucks() do
    query =
      from t in Truck,
        where: t.status == "APPROVED"

    Repo.all(query)
  end

  @spec create_or_update_truck(map()) :: {:ok, Truck} | {:error, Changeset}
  def create_or_update_truck(attrs) do
    %Truck{}
    |> Truck.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
  end

  @spec select_random_truck(list(Truck)) :: Truck
  def select_random_truck(trucks) do
    Enum.random(trucks)
  end

  @spec get_truck_of_the_day() :: Truck
  def get_truck_of_the_day() do
    list_active_trucks()
    |> select_random_truck()
  end
end
