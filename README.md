# TruckOfTheDayClub

Truck of the Day Club calls on the SODA devleoper API to obtain a list of all the current food trucks in San Fransisco, 
and exposes one of them at a time in a simple web interface as the "truck of the day" in order to provide new ideas for what to eat for lunch!

### Installation
Truck of the Day Club requires Erlang 24+ and Elixir 1.12+ If you do not have them installed already, 
please follow the excellent steps available at https://elixir-lang.org/install.html. 
Make sure to have a current installation of PostgreSQL up and running as well, in order to host the database.
  
Once Erlang and Elixir are installed, install the project dependencies with `mix deps.get`, and prepare the DB with `mix ecto.setup`, 
which will make a call to the target API and setup the database. A scheduled worker is planned to update the DB frequently. 

Start the application with `mix phx.server` and then access it at localhost:4000.

### Sample Screenshot
![image](https://user-images.githubusercontent.com/10183208/218635735-8b87f326-e3e4-4477-b8b8-35ff6a494e19.png)
