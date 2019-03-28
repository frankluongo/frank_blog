# Since configuration is shared in umbrella projects, this file
# should only configure the :frank_blog application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :frank_blog,
  ecto_repos: [FrankBlog.Repo]

import_config "#{Mix.env()}.exs"
