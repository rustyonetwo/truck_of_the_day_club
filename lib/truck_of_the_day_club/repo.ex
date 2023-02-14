defmodule TruckOfTheDayClub.Repo do
  use Ecto.Repo,
    otp_app: :truck_of_the_day_club,
    adapter: Ecto.Adapters.Postgres
end
