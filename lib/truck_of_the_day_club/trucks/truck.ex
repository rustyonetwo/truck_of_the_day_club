defmodule TruckOfTheDayClub.Trucks.Truck do
  @moduledoc """
    Truck definition and functions
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          applicant: String.t(),
          locationdescription: String.t(),
          address: String.t(),
          status: String.t(),
          fooditems: String.t(),
          schedule: String.t()
        }

  schema "trucks" do
    field :applicant, :string
    field :locationdescription, :string
    field :address, :string
    field :status, :string
    field :fooditems, :string
    field :schedule, :string

    timestamps()
  end

  def changeset(truck, attrs) do
    truck
    |> cast(attrs, [
      :applicant,
      :locationdescription,
      :address,
      :status,
      :fooditems,
      :schedule
    ])
    |> validate_required([
      :applicant,
      :address,
      :status
    ])
  end
end
