require "audible"
require "json"
# Purpose: Get every book in library.

# TODO: Parse eacy page returned from from library, when array returns empty, stop incrementing page number.

# Config.
session = Path["~/.audible.json"].expand(home: true)

# Basic library call (NOTE: limited to 99 items.)
def get_library(session)
  client = Audible::Client.from_json(File.read("#{session}"))
  client.get("/1.0/library?page=7").body
end
#get_library(session)

library = get_library(session)
puts library
