defmodule TruckOfTheDayClub.TrucksTest do
  @moduledoc false

  use TruckOfTheDayClub.DataCase

  alias TruckOfTheDayClub.Repo
  alias TruckOfTheDayClub.Trucks
  alias TruckOfTheDayClub.Trucks.Truck

  describe "list_trucks/0" do
    setup do
      truck_one = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      Truck.changeset(%Truck{}, truck_one)
      |> Repo.insert!()

      truck_two = %{
        applicant: "Testy's Old Truck",
        locationdescription: "Junkyard",
        address: "0 Zero Lane",
        status: "EXPIRED",
        fooditems: "Just moldy cheese",
        schedule: "never"
      }

      Truck.changeset(%Truck{}, truck_two)
      |> Repo.insert!()

      :ok
    end

    test "gets a list of trucks that exist" do
      [trucks | _tail] = Trucks.list_trucks()

      assert Map.has_key?(trucks, :applicant)
    end
  end

  describe "list_active_trucks" do
    setup do
      truck_one = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      Truck.changeset(%Truck{}, truck_one)
      |> Repo.insert!()

      truck_two = %{
        applicant: "Testy's Old Truck",
        locationdescription: "Junkyard",
        address: "0 Zero Lane",
        status: "EXPIRED",
        fooditems: "Just moldy cheese",
        schedule: "never"
      }

      Truck.changeset(%Truck{}, truck_two)
      |> Repo.insert!()

      :ok
    end

    test "only retrieves trucks that are still approved" do
      truck_list = Trucks.list_active_trucks()

      for truck <- truck_list do
        assert %{status: "APPROVED"} = truck
      end
    end
  end

  describe "create_or_update_truck/1" do
    setup do
      truck_one = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      Truck.changeset(%Truck{}, truck_one)
      |> Repo.insert!()

      truck_two = %{
        applicant: "Testy's Old Truck",
        locationdescription: "Junkyard",
        address: "0 Zero Lane",
        status: "EXPIRED",
        fooditems: "Just moldy cheese",
        schedule: "never"
      }

      Truck.changeset(%Truck{}, truck_two)
      |> Repo.insert!()

      :ok
    end

    test "inserts a new truck" do
      truck_three = %{
        applicant: "Testy's New Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      count = Kernel.length(Trucks.list_trucks())

      Trucks.create_or_update_truck(truck_three)

      assert Kernel.length(Trucks.list_trucks()) == count + 1
    end

    # TODO: This successfully inserts a duplicate truck. This test is left failing as a marker to come back to the feature and proof it against this issue before deployment.
    test "does not insert a duplicate truck" do
      truck_one_again = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      count = Kernel.length(Trucks.list_trucks())

      Trucks.create_or_update_truck(truck_one_again)

      assert Kernel.length(Trucks.list_trucks()) == count
    end
  end

  describe "select_random_truck/1" do
    setup do
      truck_one = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      Truck.changeset(%Truck{}, truck_one)
      |> Repo.insert!()

      truck_two = %{
        applicant: "Testy's Old Truck",
        locationdescription: "Junkyard",
        address: "0 Zero Lane",
        status: "EXPIRED",
        fooditems: "Just moldy cheese",
        schedule: "never"
      }

      Truck.changeset(%Truck{}, truck_two)
      |> Repo.insert!()

      :ok
    end

    test "selects one truck" do
      truck_list = Trucks.list_trucks()
      assert %Truck{} = Trucks.select_random_truck(truck_list)
    end
  end

  describe "get_truck_of_the_day/0" do
    setup do
      truck_one = %{
        applicant: "Testy's Truck",
        locationdescription: "Corner of 10th and Practice",
        address: "101 Test Drive",
        status: "APPROVED",
        fooditems: "Just cheese",
        schedule: "all day every day"
      }

      Truck.changeset(%Truck{}, truck_one)
      |> Repo.insert!()

      truck_two = %{
        applicant: "Testy's Old Truck",
        locationdescription: "Junkyard",
        address: "0 Zero Lane",
        status: "EXPIRED",
        fooditems: "Just moldy cheese",
        schedule: "never"
      }

      Truck.changeset(%Truck{}, truck_two)
      |> Repo.insert!()

      :ok
    end

    test "gets an active truck for totd" do
      assert %{status: "APPROVED"} = Trucks.get_truck_of_the_day()
    end
  end
end
