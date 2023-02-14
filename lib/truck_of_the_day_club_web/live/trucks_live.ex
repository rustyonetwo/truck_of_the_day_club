defmodule TruckOfTheDayClubWeb.TrucksLive do
  use TruckOfTheDayClubWeb, :live_view

  alias TruckOfTheDayClub.Trucks

  def mount(_params, _session, socket) do
    socket =
      if connected?(socket) do
        socket
        |> assign(:page_title, "Truck of the day club")
        |> get_a_random_truck_and_assign()
      else
        socket
        |> assign(:name, "")
        |> assign(:location, "")
        |> assign(:address, "")
        |> assign(:food, "")
      end

    {:ok, socket}
  end

  def handle_event("new_truck", _, socket) do
    {:noreply, get_a_random_truck_and_assign(socket)}
  end

  @spec process_food_list(String.t()) :: String.t()
  defp process_food_list(food) do
    food
    |> String.split([":", ".", ",", "\n"], trim: true)
    |> Enum.map_join(", ", fn str -> String.capitalize(str) end)
  end

  @spec get_a_random_truck_and_assign(map()) :: map()
  defp get_a_random_truck_and_assign(socket) do
    totd = Trucks.get_truck_of_the_day()

    # using dot notation like this appeased the dialyzer but I usually avoid it b/c it will crash if the object is empty
    socket
    |> assign(:name, totd.applicant)
    |> assign(:location, totd.locationdescription)
    |> assign(:address, totd.address)
    |> assign(:food, process_food_list(totd.fooditems))
  end
end
