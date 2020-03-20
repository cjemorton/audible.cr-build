require "audible"
# Purpose: Get every book in library.

# TODO: Figure out how to use different parameters for the endpoints. ex. How to request pages.

# Config.
session = Path["~/.audible.json"].expand(home: true)

#
get_library(session)

# Basic library call (NOTE: limited to 99 items.)
def get_library(session)
  client = Audible::Client.from_json(File.read("#{session}"))
  puts client.get("/1.0/library").body
end
