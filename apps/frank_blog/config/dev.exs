# Since configuration is shared in umbrella projects, this file
# should only configure the :frank_blog application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :frank_blog, FrankBlog.Repo,
  username: "postgres",
  password: "postgres",
  database: "frank_blog_dev",
  hostname: "localhost",
  pool_size: 10
