defmodule TruckOfTheDayClubWeb.TrucksLive do
  use TruckOfTheDayClubWeb, :live_view

  alias TruckOfTheDayClub.Trucks

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Truck of the day club")
      |> get_a_random_truck_and_assign()

    IO.inspect(socket, limit: :infinity)
    {:ok, socket}
  end

  def handle_event("new_truck", _, socket) do
    {:noreply, get_a_random_truck_and_assign(socket)}
  end

  defp process_food_list(food) do
    food
    |> String.split([":", ".", ",", "\n"], trim: true)
    |> Enum.map_join(", ", fn str -> String.capitalize(str) end)
  end

  defp get_a_random_truck_and_assign(%{assigns: %{name: _name}} = socket), do: socket

  defp get_a_random_truck_and_assign(socket) do
    %{applicant: name, locationdescription: location, address: address, fooditems: food} =
      Trucks.get_truck_of_the_day()

    socket
    |> assign(:name, name)
    |> assign(:location, location)
    |> assign(:address, address)
    |> assign(:food, process_food_list(food))
  end
end
