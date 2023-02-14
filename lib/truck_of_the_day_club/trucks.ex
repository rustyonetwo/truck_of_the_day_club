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

  # While this should prevent duplicate trucks it may also prevent trucks from moving, or create duplictes when trucks move
  @spec create_or_update_truck(map()) :: {:ok, Truck} | {:error, Changeset}
  def create_or_update_truck(
        %{
          "objectid" => objectid,
          "applicant" => applicant,
          "address" => address
        } = attrs
      ) do
    case Repo.get_by(Truck,
           objectid: objectid,
           applicant: applicant,
           address: address
         ) do
      nil ->
        %Truck{}
        |> Truck.changeset(attrs)
        |> Repo.insert()

      truck ->
        truck
        |> Truck.changeset(attrs)
        |> Repo.update()
    end
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
