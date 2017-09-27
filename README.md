# Tech for good near you

## What

An app to help users find `Tech for good` events. Events will be filterable by date, area of interest and location. They will be displayed on a map along with the user's location.

## Why

Currently `Tech for good` events are publicised in a range of mediums such as Twitter, MeetUp and Eventbrite. This makes it hard for interested people to get informed about all the events going on.

## How

Event data is pulled in from the Meetup API and a collection of user submitted events. The app combines all the event data and displays events in a clean, intuitive interface.

Users can enter their postcode or get their current location, select which date range they'd like to see events from and then see a list of all the events near them plus a map showing where these events are.

The app is built with:

* Elm - (frontend)
* Tachyons - (frontend)
* Elixir / Phoenix - (backend)


## Submit your event

visit https://tech-for-good-near-you.herokuapp.com/user-event/new and add your event, our moderators will look over the events and approve them to be displayed.


### Icon Credits

credits for icons used from [The Noun Project](https://thenounproject.com/) can be found in the [wiki](https://github.com/TechforgoodCAST/tech-for-good-near-you/wiki/Icon-credits)


## Get up and running

1. Clone the repository
2. Install [phoenix](https://hexdocs.pm/phoenix/installation.html)
3. Get dependencies `mix deps.get`
4. Compile dependencies `mix deps.compile`
    - [Guidance for problems installing `comeonin` with Windows ](https://github.com/riverrun/comeonin/wiki/Requirements#windows)
5. Set up database `mix ecto.create`
6. Set up database tables `mix ecto.migrate`
7. Go to `assets/` directory (`cd assets`)
8. Set up node modules `npm install`
9. Set up elm packages `elm-packages install`
10. Get back to root directory (`cd ..`)
11. run server `mix phx.server`
12. Create admin account ?
