# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :tech_for_good_near_you,
  meetup_group_ids: [
    "1277423",
    "19866282",
    "20232146",
    "18854399",
    "1302479",
    "16347132",
    "22407110",
    "12205442",
    "22082866",
    "2503312",
    "7975692",
    "19414181",
    "18542782",
    "1635343",
    "18436868",
    "19911171",
    "22216274",
    "18976100",
    "17833522",
    "18037392",
    "19201419",
    "22434994",
    "20399973",
    "22283959",
    "14592582",
    "11072312",
    "466780",
    "11972762",
    "20791546",
    "18509845",
    "22894458",
    "26967906"
  ]

# General application configuration
config :tech_for_good_near_you,
  ecto_repos: [TechForGoodNearYou.Repo]

# Configures the endpoint
config :tech_for_good_near_you, TechForGoodNearYou.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/j2KYOATdpxnRYMNtwiMoQwycA577AbuY05ToTl4unVEX1Sg/TWra1DnBZ8HtrCn",
  render_errors: [view: TechForGoodNearYou.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TechForGoodNearYou.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
