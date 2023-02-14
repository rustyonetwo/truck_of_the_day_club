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

  # TOTD is still being updated twice during page load
  @spec get_a_random_truck_and_assign(map()) :: map()
  # defp get_a_random_truck_and_assign(%{assigns: %{name: _name}} = socket), do: socket

  defp get_a_random_truck_and_assign(socket) do
    totd = Trucks.get_truck_of_the_day()

    socket
    |> assign(:name, totd.applicant)
    |> assign(:location, totd.locationdescription)
    |> assign(:address, totd.address)
    |> assign(:food, process_food_list(totd.fooditems))
  end
end
