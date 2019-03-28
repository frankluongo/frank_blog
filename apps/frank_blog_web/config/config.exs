# Since configuration is shared in umbrella projects, this file
# should only configure the :frank_blog_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :frank_blog_web,
  ecto_repos: [FrankBlog.Repo],
  generators: [context_app: :frank_blog]

# Configures the endpoint
config :frank_blog_web, FrankBlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e8vwxTQcmyOcTmg4MgWZ8ORxbh2wzfxCwbj6gentHaicPG6Neg0VOgaVN84h5R7Y",
  render_errors: [view: FrankBlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FrankBlogWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
