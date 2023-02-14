defmodule TruckOfTheDayClub.Repo.Migrations.FoodTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :applicant, :string
      add :locationdescription, :text
      add :address, :string
      add :status, :string
      add :fooditems, :text
      add :schedule, :string

      timestamps()
    end
  end
end
